import 'package:flutter/material.dart';

import './terms_&_condtions.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
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
              counterText: "",
              hintText: 'Username',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.person),
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
            maxLength: 20,
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Mobile Number',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.phone_android_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requred';
              }
              if (!RegExp(r'^[9][8][0-9]').hasMatch(value) ||
                  value.length < 10) {
                return 'Invalid Mobile Number';
              }
              return null;
            },
            maxLength: 10,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Address',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                return 'Invalid Address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Postal Code',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.location_on_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requred';
              }
              if (!RegExp(r'^[4][4]+600').hasMatch(value) || value.length < 5) {
                return 'Invalid Postal Code';
              }
              return null;
            },
            maxLength: 5,
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: Icon(Icons.email_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requred';
              }
              if (!RegExp(r'^[a-z0-9]+@gmail\.com+$').hasMatch(value)) {
                return 'Invalid Email Address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Password',
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
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Confirm Password',
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
        ],
      ),
    );
  }

  _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // CheckboxListTile(
          //   activeColor: Theme.of(context).primaryColor,
          //   title: Text("I agree to the Terms & Conditions"),
          //   value: false,
          //   onChanged: null,
          //   controlAffinity: ListTileControlAffinity.leading,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: Theme.of(context).accentColor,
                value: _isChecked,
                onChanged: (val) {
                  setState(() {
                    _isChecked = val!;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditions()));
                },
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Color.fromARGB(255, 70, 70, 70),
                    ),
                    children: [
                      TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _isChecked
              ? ElevatedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(15),
                          elevation: 5,
                          content: Text('Registering in please wait'),
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15)),
                  ),
                )
              : ElevatedButton(
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
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15)),
                  ),
                ),
        ],
      ),
    );
  }
}
