import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:garbage_master/services/db_helper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/localNotify.dart';
import '../widgets/main_screen.dart';
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

  bool isImageIconPressed = false;

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
        _imgFile = pickedFile;
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
          margin: const EdgeInsets.all(15),
          child: FutureBuilder<Users>(
            future: user,
            builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
              if (snapshot.hasData) {
                String? firstName = snapshot.data!.FName.toString();
                String? middleName = snapshot.data!.MName.toString();
                String? lastName = snapshot.data!.LName.toString();
                String? ward = snapshot.data!.Ward.toString();
                String? phone = snapshot.data!.Phone.toString();
                String? img = snapshot.data!.Image
                    .substring(
                      22,
                    )
                    .toString();

                firstNameController.text = firstName;
                middleNameController.text = middleName;
                lastNameController.text = lastName;
                wardController.text = ward;
                phoneNumberController.text = phone;
                final Uint8List base64Decodeimg = base64Decode(img);

                // final file = File(_imgFile!.path);
                // final image = MemoryImage(base64Decodeimg);
                // print(image);

                // file.writeAsBytes(base64Decodeimg);

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
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  isReadOnly = !isReadOnly;
                                  isDisabled = !isDisabled;
                                },
                              );
                            },
                            child: !isDisabled
                                ? const Text(
                                    'Undo',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : const Text(
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
                              FirebaseMessaging.instance.unsubscribeFromTopic(
                                  'ward${wardController.text}');
                              DatabaseHelper().clearNotifications();
                              DatabaseHelper().clearWard();

                              LocalNotificationService.notificationsPlugin
                                  .cancelAll();

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('username');
                              await FirebaseMessaging.instance.deleteToken();
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

                                  Navigator.pop(context, true);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Colors.red,
                              ),
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
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.35,
                              width: MediaQuery.of(context).size.width * 0.35,
                              clipBehavior: Clip.hardEdge,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: _imgFile == null
                                  ? Image.memory(
                                      base64Decodeimg,
                                      fit: BoxFit.cover,
                                    )
                                  : isImageIconPressed == true
                                      ? Image(
                                          image:
                                              FileImage(File(_imgFile!.path)),
                                          fit: BoxFit.cover,
                                        )
                                      : const Image(
                                          image: AssetImage(
                                            'assets/images/profile-image.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                          isDisabled == false
                              ? Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.image,
                                        size: 26,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          isImageIconPressed =
                                              !isImageIconPressed;
                                        });
                                        pickImage(ImageSource.gallery);
                                      },
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
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
                      decoration: InputDecoration(
                        // hintText: snapshot.data!.FName.toString(),
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mobile Number',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: isReadOnly,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(?:[1-9]|[1-2][0-9]|3[0-2])$'),
                        )
                      ],
                      decoration: InputDecoration(
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

                                if (phoneNumberController.text.isNotEmpty) {
                                  if (!RegExp(r'^98\d{8}$')
                                      .hasMatch(phoneNumberController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSnackBarWidget(
                                        'Invalid mobile number',
                                        Theme.of(context).errorColor,
                                      ),
                                    );
                                    return;
                                  }
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

                                if (_imgFile != null) {
                                  final imgSizeInBytes =
                                      (await File(_imgFile!.path).readAsBytes())
                                          .lengthInBytes;
                                  final imgSizeInKB = imgSizeInBytes / 1024;
                                  if (imgSizeInKB <= 100) {
                                    final imgAsBytes =
                                        await File(_imgFile!.path)
                                            .readAsBytes();

                                    final String image =
                                        base64Encode(imgAsBytes);
                                    log(image.toString());
                                    final insertImageResponse =
                                        await APIServices.insertImage(
                                      {
                                        "name": userName.trim(),
                                        "image":
                                            "data:image/png;base64,${base64Encode(imgAsBytes)}",
                                      },
                                    );
                                    log(insertImageResponse.body.toString());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSnackBarWidget(
                                        'Image size must be less than 100 kb',
                                        Theme.of(context).errorColor,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                    return;
                                  }

                                  // if (insertImageResponse.statusCode == 200) {
                                  //   if ((jsonDecode(response.body)["result"])
                                  //           .toString() ==
                                  //       'Inserted') {}
                                  // }

                                }

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
                                    Navigator.pop(context, true);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainScreen(),
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
