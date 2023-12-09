import 'package:flutter/material.dart';

class Obscure extends ChangeNotifier {
  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  bool _isTyped = false;
  bool get isTyped => _isTyped;
  void toggleTyped(value) {
    _isTyped = value.isNotEmpty;

    notifyListeners();
  }
}

class PhoneProvider extends ChangeNotifier {
  late TextEditingController _controller;

  PhoneProvider() {
    _controller = TextEditingController();
    _controller.addListener(_updateState);
  }

  TextEditingController get controller => _controller;

  bool get isMaxLengthReached => _controller.text.length == 10;

  void _updateState() {
    notifyListeners();
  }
}
