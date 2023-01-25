import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final Image icon;
  final String title;
  final String subTitle;
  final String description;
  final TextField textField;

  InputCard(
      this.icon, this.title, this.subTitle, this.description, this.textField);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: icon,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 295,
                    child: Text(description),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 200,
                    child: textField,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
