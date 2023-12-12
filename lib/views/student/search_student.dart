import 'package:checkout/views/auth/widgets/textformfield_widget.dart';
import 'package:checkout/views/student/widgets/student_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/student.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StudentSearch extends StatefulWidget {
  const StudentSearch({super.key});

  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  final TextEditingController _nameController = TextEditingController();
  List<Student> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomField(
              hintText: 'Enter student name',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchStudents(_nameController.text);
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final student = _searchResults[index];
                  return StudentCard(student: student);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchStudents(String name) async {
    final results = await _firestore
        .collection('students')
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: '$name\uf8ff')
        .get();
    setState(() {
      _searchResults =
          results.docs.map((doc) => Student.fromSnapshot(doc)).toList();
    });
  }
}
