import 'package:flutter/material.dart';

class PasswordVerification extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PasswordVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
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
                      return 'Please enter the provided code';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15,
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
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
