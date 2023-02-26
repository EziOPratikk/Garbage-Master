import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/api.services.dart';

class ContactPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              _header(context),
              const SizedBox(height: 30),
              _body(context),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 2,
              ),
              const SizedBox(height: 10),
              _footer(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const Text(
            'CONTACT US',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Right now, we do not have any designated office built for this project, we have provided address, phone number below that can be used only during emergency. Otherwise you can leave us a message via email or the message section below.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _body(context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    final textFieldFillColor = Theme.of(context).primaryColor.withOpacity(0.2);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Your Name",
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
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
            controller: nameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Your Email",
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
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
          TextFormField(
            decoration: InputDecoration(
              hintText: "Subject",
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
            ),
            controller: subjectController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            textAlign: TextAlign.start,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "Message",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              border: outlineInputBorder,
              fillColor: textFieldFillColor,
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }

              return null;
            },
            controller: messageController,
          ),
          const SizedBox(height: 20),
          Align(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final response = await APIServices.contactUs({
                    "name": nameController.text.trim(),
                    "email": emailController.text.trim(),
                    "subject": subjectController.text.trim(),
                    "message": messageController.text.trim()
                  });
                  if (response.statusCode == 200) {
                    if ((jsonDecode(response.body)["result"]).toString() ==
                        'Submitted') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(15),
                          elevation: 5,
                          content: const Text('Submitted'),
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor));
                      nameController.text = '';
                      emailController.text = '';
                      subjectController.text = '';
                      messageController.text = '';
                    } else if ((jsonDecode(response.body)["result"])
                            .toString() ==
                        'Not Submitted') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(15),
                          elevation: 5,
                          content: const Text('Not Submitted'),
                          backgroundColor: Theme.of(context).errorColor));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(15),
                        elevation: 5,
                        content: const Text('Connection error'),
                        backgroundColor: Theme.of(context).errorColor));
                  }
                }
              },
              child: const Text(
                'Send',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _footer(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        CircleItemWidget(
          icon: Icon(Icons.location_on_outlined),
          title: 'Location',
          subTitle: 'Tarakeshwor-9,',
          subTitle1: 'Kathmandu Street',
          subTitle2: '219 P.O. 4050',
        ),
        CircleItemWidget(
          icon: Icon(
            Icons.mail_outline,
          ),
          title: 'Email',
          subTitle: 'garbagemaster1417',
          subTitle1: '@gmail.com',
        ),
        CircleItemWidget(
          icon: Icon(Icons.phone_android_outlined),
          title: 'Call',
          subTitle: '+977 986-141726',
        ),
      ],
    );
  }
}

class CircleItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;
  final String subTitle1;
  final String subTitle2;

  const CircleItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.subTitle1 = '',
    this.subTitle2 = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: icon,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 13),
        ),
        Text(
          subTitle1,
          style: const TextStyle(fontSize: 13),
        ),
        Text(
          subTitle2,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }
}
