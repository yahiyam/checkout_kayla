import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

class PhoneNumberProvider extends ChangeNotifier {
  late TextEditingController _controller;

  PhoneNumberProvider() {
    _controller = TextEditingController();
    _controller.addListener(_updateState);
  }

  TextEditingController get controller => _controller;

  bool get isMaxLengthReached => _controller.text.trim().length == 10;

  void _updateState() {
    notifyListeners();
  }
}

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  InternetProvider() {
    checkInternetConnection();
  }

  Future checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet = false;
    } else {
      _hasInternet = true;
    }
    notifyListeners();
  }
}

class ImagesProvider extends ChangeNotifier {
  XFile? imageXFile;

  Future<void> pickGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    imageXFile = pickedImage;
    notifyListeners();
  }

  Future<void> pickCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    imageXFile = pickedImage;
    notifyListeners();
  }

  void clearImage() {
    imageXFile = null;
    notifyListeners();
  }
}
