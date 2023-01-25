import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  child: Image.asset('assets/images/forgot password.png',
                      fit: BoxFit.cover),
                ),
                Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Don\'t worry!. Just enter the email address associated with your account then you\'re good to go.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff767676),
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 30),
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
                          prefixIcon: Icon(Icons.email_rounded),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(15),
                                elevation: 5,
                                content: Text('Loading please wait....'),
                                backgroundColor: Theme.of(context)
                                    .snackBarTheme
                                    .backgroundColor,
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 15,
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
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
