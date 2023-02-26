import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String snackBarMsg;
  final Color? snackBarColor;

  const SnackBarWidget({
    super.key,
    required this.snackBarMsg,
    required this.snackBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      elevation: 5,
      content: Text(snackBarMsg),
      backgroundColor: snackBarColor,
    );
  }
}
