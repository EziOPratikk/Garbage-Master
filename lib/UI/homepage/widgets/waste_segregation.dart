import 'package:flutter/material.dart';

class WasteSegregation extends StatelessWidget {
  const WasteSegregation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 40),
                    Icon(
                      Icons.recycling_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 35,
                    ),
                    const Text(
                      'Waste Segregation',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset(
                    'assets/images/Waste Segregation.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What is Waste Segregation ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Waste segregation can be defined as the process of identifying, classifying,dividing and sorting of garbage and waste products in an effort to reduce, reuse and recycle materials. In order to segregate waste appropriately, it is important to correctly identify the type waste that is generated such as dry waste, wet waste, sanitary waste, household waste etc.',
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Why Segregate Waste ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Segregation of waste can help to reduce the waste that gets landfilled. Pollutions such as air, water and environmental pollution rates are also lowered. Segregating waste also makes it easier to apply different processes - composting, recycling and incineration can be applied to different kinds of waste.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Here are some steps you can follow to manage and segregate waste:',
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Keep separate containers for dry and wet waste in the kitchen.',
                    ),
                    SizedBox(height: 5),
                    Text(
                      '2. Keep two bags for dry waste collection- paper and plastic, for the rest of the household waste.',
                    ),
                    SizedBox(height: 5),
                    Text(
                      '3. Keep plastic from the kitchen clean and dry and drop into the dry waste bin. Keep glass/plastic containers rinsed of food matter.',
                    ),
                    SizedBox(height: 5),
                    Text(
                      '4. Send wet waste out of your home daily. Store and send dry waste out of the home, once a week.',
                    ),
                    SizedBox(height: 5),
                    Text(
                      '5. Keep a paper bag for throwing the sanitary waste.',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
