import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
    final textFieldFillColor = Theme.of(context).primaryColor.withOpacity(0.2);
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
                            spreadRadius: 3,
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
                        foregroundImage:
                            const AssetImage('assets/images/user_profile.png'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 26,
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
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
                decoration: InputDecoration(
                  hintText: 'User',
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
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'user@gamil.com',
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
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '9812312312',
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
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Bagmati',
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
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Kathmandu',
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
                enabled: false,
                decoration: InputDecoration(
                  hintText: '10',
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
