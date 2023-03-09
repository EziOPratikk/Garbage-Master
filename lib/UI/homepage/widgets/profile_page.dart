import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:garbage_master/services/db_helper.dart';
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
  Future<Users>? user = getProfileData();

  XFile? _imgFile;
  final ImagePicker _imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final wardController = TextEditingController();

  bool isReadOnly = true;

  bool isDisabled = true;

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
          child: FutureBuilder<Users>(
            future: user,
            builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary),
                            ),
                            onPressed: () {
                              setState(() {
                                isReadOnly = !isReadOnly;
                                isDisabled = !isDisabled;
                              });
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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
                                      Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor,
                                    ),
                                  );
                                  DatabaseHelper().clearNotifications();
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
                              radius: 70,
                              foregroundImage: _imgFile == null
                                  ? const AssetImage(
                                      'assets/images/profile-image.png')
                                  : FileImage(File(_imgFile!.path))
                                      as ImageProvider,
                            ),
                          ),
                          isDisabled == false
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 26,
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'First Name',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: isReadOnly,
                      // initialValue: user?.FName.toString(),
                      decoration: InputDecoration(
                        hintText: snapshot.data!.FName.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
                      ),
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Middle Name',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: isReadOnly,
                      // initialValue: user?.MName.toString(),
                      decoration: InputDecoration(
                        hintText: snapshot.data!.MName.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
                      ),
                      controller: middleNameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Last Name',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: isReadOnly,
                      // initialValue: user?.LName.toString(),
                      decoration: InputDecoration(
                        hintText: snapshot.data!.LName.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
                      ),
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Username',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: snapshot.data!.Username.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
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
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: snapshot.data!.Email.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
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
                    const SizedBox(height: 20),
                    const Text(
                      'Mobile Number',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: isReadOnly,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
                      ),
                      controller: phoneNumberController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'State',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Bagmati',
                        hintStyle: const TextStyle(
                          fontSize: 16,
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
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Kathmandu',
                        hintStyle: const TextStyle(
                          fontSize: 16,
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
                      readOnly: isReadOnly,
                      // initialValue: user?.Ward.toString(),
                      decoration: InputDecoration(
                        hintText: snapshot.data!.Ward.toString(),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: outlineInputBorder,
                        fillColor: textFieldFillColor,
                        filled: true,
                      ),
                      controller: wardController,
                    ),
                    const SizedBox(height: 20),
                    isDisabled == false
                        ? Align(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30)),
                              ),
                              onPressed: () async {
                                if (firstNameController.text.isEmpty ||
                                    lastNameController.text.isEmpty ||
                                    wardController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    showSnackBarWidget(
                                      'Required fields cannot be empty',
                                      Theme.of(context).errorColor,
                                    ),
                                  );
                                  return;
                                }
                                progressIndicator();
                                final String userName =
                                    await SharedPreferences.getInstance().then(
                                        (value) =>
                                            value.getString('username') ??
                                            'no username found');
                                final response =
                                    await APIServices.updateProfile({
                                  "fName": firstNameController.text.trim(),
                                  "mName": middleNameController.text.trim(),
                                  "lName": lastNameController.text.trim(),
                                  "phone": phoneNumberController.text.trim(),
                                  "ward": wardController.text.trim(),
                                  "username": userName.trim(),
                                });

                                if (response.statusCode == 200) {
                                  if ((jsonDecode(response.body)["result"])
                                          .toString() ==
                                      'Table Updated') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSnackBarWidget(
                                        'Profile Updated',
                                        Theme.of(context)
                                            .snackBarTheme
                                            .backgroundColor,
                                      ),
                                    );
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('phone',
                                        phoneNumberController.text.trim());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage(),
                                      ),
                                    );
                                  }
                                  if ((jsonDecode(response.body)["result"])
                                          .toString() ==
                                      'Field cannot be empty') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSnackBarWidget(
                                        'Please provide the required field',
                                        Theme.of(context).errorColor,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
