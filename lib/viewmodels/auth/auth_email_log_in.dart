import 'dart:developer';

import 'package:checkout/utils/functions/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../views/home/home_screen.dart';

class AuthEmailLogInProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? _errorMessage;

  void logIn(BuildContext context, String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  if (context.mounted)
                    {
                      showMessageDialog(context, message: "Login Successful"),
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen())),
                    }
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            _errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            _errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            _errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            _errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            _errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            _errorMessage =
                "Signing in with Email and Password is not enabled.";
            break;
          default:
            _errorMessage = "An undefined Error happened.";
        }
        if (context.mounted) {
          showMessageDialog(context, message: _errorMessage!);
        }

        log(error.code);
      }
    }
  }
}
