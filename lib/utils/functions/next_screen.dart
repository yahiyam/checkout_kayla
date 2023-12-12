import 'package:flutter/material.dart';

void nextScreen({required BuildContext context, required Widget page}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace({required BuildContext context, required Widget page}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
