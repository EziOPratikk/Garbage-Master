import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/api.services.dart';
import './password_verification.dart';
import '../../progress_indicator_widget.dart';
import '../../snackbar_widget.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Image.asset('assets/images/password.png',
                      fit: BoxFit.cover),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Don\'t worry!. Just enter the email address associated with your account then you\'re good to go.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff767676),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          filled: true,
                          prefixIcon: const Icon(Icons.email_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (!RegExp(
                                  r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                              .hasMatch(value)) {
                            return 'Invalid Email Address';
                          }

                          return null;
                        },
                        controller: emailController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            progressIndicator();
                            final responseCheckEmail =
                                await APIServices.checkEmail({
                              "Email": emailController.text.trim(),
                            });

                            final responseSendEmail =
                                await APIServices.sendEmail({
                              "Email": emailController.text.trim(),
                            });

                            final String sixDigitCode =
                                (jsonDecode(responseSendEmail.body)["result"])
                                    .toString();

                            if (responseCheckEmail.statusCode == 200) {
                              if ((jsonDecode(
                                          responseCheckEmail.body)["result"])
                                      .toString() ==
                                  'None') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  showSnackBarWidget(
                                    'Email not found',
                                    Theme.of(context).errorColor,
                                  ),
                                );

                                Navigator.of(context).pop();
                              } else {
                                progressIndicator();
                                Navigator.pop(context, true);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PasswordVerification(
                                      sixDigitCode,
                                      emailController.text.trim(),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                showSnackBarWidget(
                                  'Connection error',
                                  Theme.of(context).errorColor,
                                ),
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                            vertical: 15,
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
