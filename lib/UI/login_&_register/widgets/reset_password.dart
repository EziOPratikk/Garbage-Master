import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/api.services.dart';
import '../../snackbar_widget.dart';
import '../../progress_indicator_widget.dart';
import './login_page.dart';

class ResetPassword extends StatelessWidget {
  final String checkedEmailAddress;

  ResetPassword(this.checkedEmailAddress, {super.key});

  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    final textFieldFillColor = Theme.of(context).primaryColor.withOpacity(0.2);

    void progressIndicator() {
      showDialog(
        context: context,
        builder: (context) {
          return const ProgressIndicatorWidget();
        },
      );
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Image.asset(
                    'assets/images/padlock.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Please enter your new password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff767676),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: outlineInputBorder,
                    fillColor: textFieldFillColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.password_rounded),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 8) {
                      return 'Password should be at least of 8 characters';
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: outlineInputBorder,
                    fillColor: textFieldFillColor,
                    filled: true,
                    prefixIcon: const Icon(Icons.password_rounded),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 8) {
                      return 'Password should be at least of 8 characters';
                    }
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return 'Password and Confirm Password doesn\'t match';
                    }

                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      progressIndicator();
                      final response = await APIServices.resetPassword(
                        {
                          "Email": checkedEmailAddress,
                          "Password": passwordController.text.trim()
                        },
                      );
                      if (response.statusCode == 200) {
                        if ((jsonDecode(response.body)['result']).toString() ==
                            "Updated") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Password reset successfull',
                              Theme.of(context).snackBarTheme.backgroundColor,
                            ),
                          );
                          Navigator.pop(context, true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Password reset failed',
                              Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBarWidget(
                            'Connection Error',
                            Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
