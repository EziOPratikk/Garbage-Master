import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_master/UI/homepage/widgets/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/api.services.dart';
import '../../homepage/widgets/main_screen.dart';
import './register_page.dart';
import './forgot_password.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
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
          margin: const EdgeInsets.only(bottom: 10),
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
        ),
        const Text('Welcome to Garbage Master'),
        const SizedBox(height: 40),
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
          // TextFormField(
          //   decoration: InputDecoration(
          //     hintText: "Email",
          //     border: outlineInputBorder,
          //     fillColor: textFieldFillColor,
          //     filled: true,
          //     prefixIcon: const Icon(Icons.email_rounded),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Required';
          //     }

          //     if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
          //         .hasMatch(value)) {
          //       return 'Invalid Email Address';
          //     }

          //     return null;
          //   },
          //   controller: _emailController,
          // ),
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Username',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
                return 'Invalid Username';
              }
              return null;
            },
            controller: userNameController,
          ),
          const SizedBox(height: 20),
          //Password Text Field
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: "Password",
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
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            // onPressed: () {
            //   // APIServices.getCurses();
            // },
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // APIServices.loginUser({
                //   "email": _emailController.text.trim(),
                //   "password": _passwordController.text.trim(),
                // });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('email', _emailController.text.trim());
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(15),
                      elevation: 5,
                      content: const Text('Log in successfully'),
                      backgroundColor:
                          Theme.of(context).snackBarTheme.backgroundColor));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                } on FirebaseAuthException catch (e) {
                  // TODO
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(15),
                      elevation: 5,
                      content: Text(e.message!),
                      backgroundColor:
                          Theme.of(context).snackBarTheme.backgroundColor));
                }
              }
            },

            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 15)),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            children: [
              const Text('Don\'t have an account?'),
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
                  child: const Text('Register')),
            ],
          )
        ],
      ),
    );
  }
}
