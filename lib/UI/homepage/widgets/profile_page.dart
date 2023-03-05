import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/api.services.dart';
import '../../login_&_register/widgets/login_page.dart';
import '../../progress_indicator_widget.dart';
import '../../snackbar_widget.dart';
import '../../../models/users.dart';

Future<Users> getProfileData() async {
  var puser = await SharedPreferences.getInstance();
  puser.getString('username');
  final currentUser = await APIServices.currentUser({
    'username': await SharedPreferences.getInstance()
        .then((value) => value.getString('username') ?? 'no username found'),
  });
  var decode = jsonDecode(currentUser.body);
  Map<String, dynamic> userMap = decode;
  Users profileUser = Users.fromMap(userMap);

  return profileUser;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Users? user;
  bool isLoading = false;
  XFile? _imgFile;
  final ImagePicker _imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    getProfileData().then((value) {
      user = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    final textFieldFillColor = Theme.of(context).primaryColor.withOpacity(0.2);

    Future pickImage(ImageSource src) async {
      XFile? pickedFile = await _imgPicker.pickImage(source: src);

      setState(() {
        _imgFile = pickedFile!;
      });
    }

    void progressIndicator() {
      showDialog(
        context: context,
        builder: (context) {
          return const ProgressIndicatorWidget();
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Spacer(flex: 2),
                    const Expanded(
                      child: Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('username');
                        progressIndicator();
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              showSnackBarWidget(
                                'Logged out',
                                Theme.of(context).snackBarTheme.backgroundColor,
                              ),
                            );
                            Navigator.pop(context, true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        foregroundImage: _imgFile == null
                            ? const AssetImage('assets/images/user_profile.png')
                            : FileImage(File(_imgFile!.path)) as ImageProvider,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 26,
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Username',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: user?.Username.toString(),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: user?.Email.toString(),
                enabled: false,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Mobile Number',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: '9841******',
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: '',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'State',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: 'Bagmati',
                enabled: false,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'District',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: 'Kathmandu',
                enabled: false,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ward',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: user?.Ward.toString(),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: outlineInputBorder,
                  fillColor: textFieldFillColor,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
