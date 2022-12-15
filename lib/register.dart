import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: null,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _header(context),
                    _inputField(context),
                    _footer(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          'Registration',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text('Enter your account details'),
        SizedBox(height: 35),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Mobile Number',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Address',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Ward No.',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
          obscureText: true,
        ),
        SizedBox(height: 20),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
            filled: true,
          ),
          obscureText: true,
        ),
      ],
    );
  }

  _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckboxListTile(
            title: Text("I agree to the Terms & Conditions"),
            value: false,
            onChanged: null,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Checkbox(value: false, onChanged: null),
          //     Text('I agree to the Terms & Conditions'),
          //   ],
          // ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: null,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
