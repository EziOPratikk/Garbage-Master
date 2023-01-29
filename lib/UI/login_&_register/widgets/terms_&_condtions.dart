import 'package:flutter/material.dart';

import './register_page.dart';

class TermsConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomSheet: Container(
          height: 60,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Center(
                child: Text(
                  'Garbage Master',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Copyright 2022 Garbage Master, Inc.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                ),
                const SizedBox(width: 40),
                Icon(
                  Icons.article_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'TERMS AND CONDITIONS FOR GARBAGE MASTER ONLINE SERVICES',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            const Text(
              '1. Garbage Master Mobile Application service is exclusively for the public who are registered. The user must provide genuine data based on the wastes available at their location.',
            ),
            const SizedBox(height: 15),
            const Text(
              '2. The users should provide genuine information while registering such as Ward no, Mobile number, Address etc and also keep the Email or Password safe.',
            ),
            const SizedBox(height: 15),
            const Text(
              '3. The users should input data about the waste on the daily basis. The user should not use the Garbage Master Mobile Application to provide unnecessary data and if such case happens then the user should accept full responsibility and hence will not be able to use the application anymore.',
            ),
            const SizedBox(height: 15),
            const Text(
                '4. Any changes or additions to the Specified Service or certain Conditions must be agreed in writing by the Company and the Client.'),
            const SizedBox(height: 15),
            const Text(
                '5. Garbage Master will use its best endeavours to provide the Specified Service on the date and time that has been scheduled but accepts no liability or loss resulting from late or delayed arrival to the desired location.'),
          ],
        ),
      ),
    ));
  }
}
