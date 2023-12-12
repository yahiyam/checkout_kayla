import 'dart:io';

import 'package:checkout/utils/widgets/button.dart';
import 'package:checkout/views/auth/widgets/textformfield_widget.dart';
import 'package:checkout/views/student/Functions/image_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/functions/dialog_utils.dart';
import '../../viewmodels/base_viewmodel.dart';
import '../../viewmodels/student_viewmodel.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagesProvider imageProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Consumer<StudentViewModel>(builder: (context, student, _) {
        return Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: student.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<ImagesProvider>(
                  builder: (context, imageProvider, _) => Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 90,
                            backgroundColor: AppColors.splash,
                            backgroundImage: imageProvider.imageXFile == null
                                ? null
                                : FileImage(
                                    File(imageProvider.imageXFile!.path)),
                            child: imageProvider.imageXFile == null
                                ? const Icon(
                                    Icons.person,
                                    color: AppColors.neutral,
                                    size: 110,
                                  )
                                : null,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: imageProvider.imageXFile == null
                                ? IconButton(
                                    onPressed: () {
                                      showImageSourceDialog(
                                          context, imageProvider);
                                    },
                                    icon: const Icon(
                                      Icons.touch_app,
                                      color: AppColors.neutral,
                                    ))
                                : IconButton(
                                    onPressed: () => imageProvider.clearImage(),
                                    icon: const Icon(
                                      Icons.clear,
                                      color: AppColors.neutral,
                                    )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomField(
                      controller: student.nameController,
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomField(
                      controller: student.ageController,
                      hintText: 'Age',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an age';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Submit',
                  onTap: () {
                    if (student.formKey.currentState!.validate() &&
                        imageProvider.imageXFile != null) {
                      student.addStudent(
                        student.nameController.text,
                        int.parse(student.ageController.text),
                        imageProvider.imageXFile,
                      );
                      imageProvider.clearImage();
                      student.nameController.clear();
                      student.ageController.clear();
                      Navigator.pop(context);
                    } else {
                      showMessageDialog(context,
                          message: 'Please select an image');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
