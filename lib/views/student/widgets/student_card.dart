import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/student.dart';
import '../../../viewmodels/student_viewmodel.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.student,
    this.showDelete = false,
  });

  final Student student;
  final bool? showDelete;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StudentViewModel>(context, listen: false);

    Future<void> showDeleteConfirmationDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this student?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  model.deleteStudent(student.id, student.photoUrl);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(student.photoUrl),
      ),
      title: Text(student.name),
      subtitle: Text('Age: ${student.age}'),
      trailing: showDelete == true
          ? IconButton(
              onPressed: () {
                showDeleteConfirmationDialog();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          : null,
    );
  }
}
