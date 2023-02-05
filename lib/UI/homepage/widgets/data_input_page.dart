import 'package:flutter/material.dart';

import './input_card.dart';

class DataInputPage extends StatelessWidget {
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
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
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 15),
                    decoration: textInputDecoration,
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
                  onPressed: () {},
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
