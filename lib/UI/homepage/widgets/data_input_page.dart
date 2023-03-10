import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './input_card.dart';
import '../../../models/api.services.dart';
import '../../snackbar_widget.dart';
import '../.././homepage/widgets/main_screen.dart';

class DataInputPage extends StatelessWidget {
  DataInputPage({super.key});

  final smallPlasticController = TextEditingController();
  final bigPlasticController = TextEditingController();
  final dustBinController = TextEditingController();
  final sackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textInputDecoration = InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      hintText: 'Quantity in Units',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                const Text(
                  'GARBAGE DATA',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('Thank you for participating in our program'),
                const Text(
                    'By following us you too are contributing for this society'),
                const SizedBox(height: 15),
                InputCard(
                  Image.asset(
                    'assets/images/plastic.png',
                    fit: BoxFit.cover,
                  ),
                  'Small Bag',
                  'Number of filled plastics',
                  'Small plastics refers to bags that contains very small amount of wastes. We advise you not to count without filling the entire bag. The filled bag allows us to measure the data more efficiently.',
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
                    controller: smallPlasticController,
                  ),
                ),
                const SizedBox(height: 15),
                InputCard(
                  Image.asset(
                    'assets/images/bigbag.png',
                    fit: BoxFit.cover,
                  ),
                  'Big Bag',
                  'Number of filled plastics',
                  'Big bag refers to bags that contains large amount of wastes. We advise you not to count without filling the entire bag. The filled bag allows us to measure the data more efficiently.',
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
                    controller: bigPlasticController,
                  ),
                ),
                const SizedBox(height: 15),
                InputCard(
                  Image.asset(
                    'assets/images/bin.png',
                    fit: BoxFit.cover,
                  ),
                  'Dust Bin',
                  'Number of filled Dustbin',
                  'Dust bin refers to storage that contain large amount of wastes. If the dustbin is very small, please count it in plastic zone. We advise you not to count without filling the entire bin to make it more efficient',
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
                    controller: dustBinController,
                  ),
                ),
                const SizedBox(height: 15),
                InputCard(
                  Image.asset(
                    'assets/images/sack.png',
                    fit: BoxFit.cover,
                  ),
                  'Sack Bag',
                  'Number of filled sack bags',
                  'Sack bag refers to bags that contains very large amount of wastes. We advise you not to count without filling the entire bag. The filled bag allows us to measure the data more efficiently.',
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
                    controller: sackController,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30)),
                  ),
                  onPressed: () async {
                    if (smallPlasticController.text.isEmpty &&
                        bigPlasticController.text.isEmpty &&
                        dustBinController.text.isEmpty &&
                        sackController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBarWidget(
                          'All fields cannot be empty',
                          Theme.of(context).errorColor,
                        ),
                      );
                      return;
                    }
                    var puser = await SharedPreferences.getInstance();
                    String? user = puser.getString('username');

                    final response = await APIServices.updateGarbageData({
                      "sp": smallPlasticController.text.trim(),
                      "bp": bigPlasticController.text.trim(),
                      "db": dustBinController.text.trim(),
                      "sack": sackController.text.trim(),
                      "uname": user,
                    });

                    if (response.statusCode == 200) {
                      if ((jsonDecode(response.body)['result']).toString() ==
                          "Updated") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBarWidget(
                            'Updated successfully',
                            Theme.of(context).snackBarTheme.backgroundColor,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      }
                      if ((jsonDecode(response.body)['result']).toString() ==
                          "spam") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBarWidget(
                            'Spam data recorded. Please enter valid data only',
                            Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBarWidget(
                          'Connection Error',
                          Theme.of(context).errorColor,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
