import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/ward.dart';
import './login_page.dart';
import '../../../models/api.services.dart';
import './terms_&_condtions.dart';
import '../../progress_indicator_widget.dart';
import '../../snackbar_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final List<Ward> dropDownWardList = [
    Ward(id: 1, title: 'Ward 1 Naksal'),
    Ward(id: 2, title: 'Ward 2 Lazimpat'),
    Ward(id: 3, title: 'Ward 3 Maharajgunj'),
    Ward(id: 4, title: 'Ward 4 Baluwatar'),
    Ward(id: 5, title: 'Ward 5 Hadigaun'),
    Ward(id: 6, title: 'Ward 6 Bouddha'),
    Ward(id: 7, title: 'Ward 7 Mitrapark'),
    Ward(id: 8, title: 'Ward 9 Gaushala'),
    Ward(id: 9, title: 'Ward 9 Gaushala'),
    Ward(id: 10, title: 'Ward 10 Baneshwor'),
    Ward(id: 11, title: 'Ward 11 Tripureshwor'),
    Ward(id: 12, title: 'Ward 12 Teku'),
    Ward(id: 13, title: 'Ward 13 Kalimati'),
    Ward(id: 14, title: 'Ward 14 Kalanki'),
    Ward(id: 15, title: 'Ward 15 Dallu'),
    Ward(id: 16, title: 'Ward 16 Sorakhuttey'),
    Ward(id: 17, title: 'Ward 17 Chhetrapti'),
    Ward(id: 18, title: 'Ward 18 Nardevi'),
    Ward(id: 19, title: 'Ward 19 Damatol'),
    Ward(id: 20, title: 'Ward 20 Bhimsensthan'),
    Ward(id: 21, title: 'Ward 21 Jawalakhel'),
    Ward(id: 22, title: 'Ward 22 Tewanhal'),
    Ward(id: 23, title: 'Ward 23 Ombahal'),
    Ward(id: 24, title: 'Ward 24 Makhan'),
    Ward(id: 25, title: 'Ward 25 Masangali'),
    Ward(id: 26, title: 'Ward 26 Lainchaur'),
    Ward(id: 27, title: 'Ward 27 Mahabouddha'),
    Ward(id: 28, title: 'Ward 28 Old Buspark'),
    Ward(id: 29, title: 'Ward 29 Dillibazar Pipal'),
    Ward(id: 30, title: 'Ward 30 Gyaneshowr'),
    Ward(id: 31, title: 'Ward 31 Bhimsengola'),
    Ward(id: 32, title: 'Ward 32 Koteshwor'),
  ];

  late int dropDownWardValue;

  void progressIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return const ProgressIndicatorWidget();
      },
    );
  }

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
          // Username
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: 'First Name',
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
            controller: firstNameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Middle Name',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.person),
            ),
            maxLength: 20,
            controller: middleNameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              counterText: "",
              hintText: 'Last Name',
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
            controller: lastNameController,
          ),
          const SizedBox(height: 20),
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
            controller: userNameController,
          ),
          const SizedBox(height: 20),
          //Ward input
          DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: 'Kathmandu Metro Ward',
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
              prefixIcon: const Icon(Icons.location_on_rounded),
            ),
            menuMaxHeight: 200,
            items: dropDownWardList.map((Ward item) {
              return DropdownMenuItem(
                value: item.id,
                child: Text(item.title),
              );
            }).toList(),
            onChanged: (int? val) {
              setState(() {
                dropDownWardValue = val!;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          //Email
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
                return 'Required';
              }
              if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                  .hasMatch(value)) {
                return 'Invalid Email Address';
              }
              return null;
            },
            controller: emailController,
          ),
          const SizedBox(height: 20),

          //Password
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
                return 'Password should be at least of 8 characters';
              }
              return null;
            },
            controller: passwordController,
          ),
          const SizedBox(height: 20),

          //Confirm Password
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
                return 'Password should be at least of 8 characters';
              }

              if (passwordController.text != confirmPasswordController.text) {
                return 'Password and Confirm Password doesn\'t match';
              }

              return null;
            },
            controller: confirmPasswordController,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  _footer(context) {
    return SizedBox(
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
                          builder: (context) => const TermsConditions()));
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      progressIndicator();
                      final response = await APIServices.registerUser({
                        "fName": firstNameController.text.trim(),
                        "mName": middleNameController.text.trim(),
                        "lName": lastNameController.text.trim(),
                        "email": emailController.text.trim(),
                        "username": userNameController.text.trim(),
                        "password": passwordController.text.trim(),
                        "ward": dropDownWardValue.toString(),
                      });

                      if (response.statusCode == 200) {
                        Navigator.of(context).pop();
                        if ((jsonDecode(response.body)["result"]).toString() ==
                            'UserRegistered') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Register Successfull',
                              Theme.of(context).snackBarTheme.backgroundColor,
                            ),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        } else if ((jsonDecode(response.body)["result"])
                                .toString() ==
                            'UsernameExists') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Username is already taken',
                              Theme.of(context).errorColor,
                            ),
                          );
                        } else if ((jsonDecode(response.body)["result"])
                                .toString() ==
                            'EmailExists') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Email is already registered',
                              Theme.of(context).errorColor,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBarWidget(
                              'Register Failed',
                              Theme.of(context).errorColor,
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
