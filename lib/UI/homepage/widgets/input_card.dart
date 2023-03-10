import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final Image icon;
  final String title;
  final String subTitle;
  final String description;
  final TextField textField;

  const InputCard(
      this.icon, this.title, this.subTitle, this.description, this.textField,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subTitle,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 295,
                  child: Text(description),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: textField,
                ),
                const SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}
