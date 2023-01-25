import 'package:flutter/material.dart';

import './home_page.dart';
import './register_page.dart';
import './forgot_password.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
            ],
          ),
        ),
      )),
    );
  }

  _header(context) {
    return Column(
      children: [
        Container(
          height: 200,
          margin: EdgeInsets.only(bottom: 10),
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
        ),
        Text('Welcome to Garbage Master'),
        SizedBox(height: 40),
      ],
    );
  }

  _inputField(context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    final textFieldFillColor = Theme.of(context).primaryColor.withOpacity(0.2);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Email",
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.email_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }

              // if (!RegExp(r'^[a-z0-9]+@gmail\.com+$').hasMatch(value)) {
              //   return 'Invalid Email Address';
              // }
              if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                  .hasMatch(value)) {
                return 'Invalid Email Address';
              }

              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: "Password",
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.password_rounded),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }

              return null;
            },
            maxLength: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text('Forgot Password')),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(15),
                    elevation: 5,
                    content: Text('Logging in please wait'),
                    backgroundColor:
                        Theme.of(context).snackBarTheme.backgroundColor,
                  ),
                );
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Homepage()));
              }
            },
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
            ),
          ),
          Row(
            children: [
              Text('Don\'t have an account?'),
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text('Register')),
            ],
          )
        ],
      ),
    );
  }
}
