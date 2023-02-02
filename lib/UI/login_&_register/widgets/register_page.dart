import 'package:flutter/material.dart';

import './login_page.dart';
import '../../../models/api.services.dart';
import '../../../models/user.dart';
import './terms_&_condtions.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  final List<String> dropDownList = [
    'Ward 1 Naksal',
    'Ward 2 Lazimpat',
    'Ward 3 Maharajgunj',
    'Ward 4 Baluwatar',
    'Ward 5 Hadigaun',
    'Ward 6 Bouddha',
    'Ward 7 Mitrapark',
    'Ward 8 Jayabageshwori',
    'Ward 9 Gaushala',
    'Ward 10 Baneshwor',
    'Ward 11 Tripureshwor',
    'Ward 12 Teku',
    'Ward 13 Kalimati',
    'Ward 14 Kalanki',
    'Ward 15 Dallu',
    'Ward 16 Sorakhuttey',
    'Ward 17 Chhetrapti',
    'Ward 18 Nardevi',
    'Ward 19 Damatol',
    'Ward 20 Bhimsensthan',
    'Ward 21 Jawalakhel',
    'Ward 22 Tewanhal',
    'Ward 23 Ombahal',
    'Ward 24 Makhan',
    'Ward 25 Masangali',
    'Ward 26 Lainchaur',
    'Ward 27 Mahabouddha',
    'Ward 28 Old Buspark',
    'Ward 29 Dillibazar Pipal',
    'Ward 30 Gyaneshowr',
    'Ward 31 Bhimsengola',
    'Ward 32 Koteshwor',
  ];
  String? dropDownValue;

  final _userNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(5),
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
      children: const [
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
            maxLength: 20,
            controller: _userNameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Mobile Number',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.phone_android_rounded),
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
            controller: _mobileNumberController,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: 'Kathmandu Metro Ward',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.location_on_rounded),
            ),
            menuMaxHeight: 200,
            items: dropDownList.map((String item) {
              return DropdownMenuItem(
                child: Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (String? val) {
              setState(() {
                dropDownValue = val!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.email_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requred';
              }
              if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                  .hasMatch(value)) {
                return 'Invalid Email Address';
              }
              return null;
            },
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              counterText: "",
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
                return 'Password should be atleast of 8 characters';
              }

              return null;
            },
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              counterText: "",
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
                return 'Password should be atleast of 8 characters';
              }

              if (_passwordController.text != _confirmPasswordController.text) {
                return 'Password and Confirm Password doesn\'t match';
              }

              return null;
            },
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: Theme.of(context).colorScheme.secondary,
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
                    style: const TextStyle(
                      color: Color.fromARGB(255, 70, 70, 70),
                    ),
                    children: [
                      const TextSpan(text: 'I agree to the '),
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
          const SizedBox(height: 10),
          _isChecked
              ? ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(15),
                          elevation: 5,
                          content: const Text('Register Successfull'),
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor));
                      APIServices.registerUser({
                        "username": _userNameController.text.trim(),
                        "mobilenumber": _mobileNumberController.text.trim(),
                        "ward": dropDownValue,
                        "email": _emailController.text.trim(),
                        "password": _passwordController.text.trim(),
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
                        const EdgeInsets.symmetric(vertical: 15)),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ElevatedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 15)),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ],
      ),
    );
  }
}
