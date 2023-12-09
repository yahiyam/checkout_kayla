import 'dart:io';

import 'package:checkout/utils/functions/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context, e.toString());
    }
  }
  return image;
}
