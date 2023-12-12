import 'package:flutter/material.dart';

Future<void> showImageSourceDialog(context, imageProvider) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  imageProvider.pickCameraImage();
                },
                child: const Text('Camera'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  imageProvider.pickGalleryImage();
                },
                child: const Text('Gallery'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
