import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
          ],
        ),
      )),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          'LOGO',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text('Welcome to Garbage Master'),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
          obscureText: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: Text('Forgot Password')),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
          ),
        ),
        Row(
          children: [
            Text('Don\'t have an account?'),
            TextButton(onPressed: () {}, child: Text('Register')),
          ],
        )
      ],
    );
  }
}
