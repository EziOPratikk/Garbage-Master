import 'package:flutter/material.dart';

import '../../snackbar_widget.dart';
import './reset_password.dart';

class PasswordVerification extends StatelessWidget {
  final String sixDigitCode;
  final String checkedEmailAddress;

  PasswordVerification(this.sixDigitCode, this.checkedEmailAddress,
      {super.key});

  final _formKey = GlobalKey<FormState>();

  final sixDigitCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset(
                  'assets/images/smartphone.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Please check your inbox and enter the 6 digit code provided in the email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff767676),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "XXXXXX",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the pin provided in your email';
                    }
                    return null;
                  },
                  controller: sixDigitCodeController,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Theme.of(context).primaryColor),
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15,
                  )),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = sixDigitCode;

                    if (response == sixDigitCodeController.text.toString()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResetPassword(checkedEmailAddress),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBarWidget(
                          'Invalid Pin',
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
    );
  }
}
