import 'package:flutter/material.dart';

SnackBar showSnackBarWidget(String text, Color? bgColor) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(15.0),
    elevation: 5,
    content: Text(text),
    backgroundColor: bgColor,
  );
}
