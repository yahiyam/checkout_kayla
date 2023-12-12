import 'dart:developer';
import 'dart:io';
import 'package:checkout/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<void> addStudent(String name, int age, XFile? imageFile) async {
    try {
      final documentReference =
          FirebaseFirestore.instance.collection('students').doc();

      String imageURL = await _uploadImageToFirebaseStorage(
        imageFile!,
        documentReference.id,
      );

      final student = Student(
        id: documentReference.id,
        name: name,
        age: age,
        photoUrl: imageURL,
      );

      await documentReference.set(student.toMap());

      log('Student added successfully!');
    } catch (error) {
      log('Error adding student: $error');
    }
  }

  Future<String> _uploadImageToFirebaseStorage(
      XFile imageFile, String documentId) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child(
          'students/$documentId/${DateTime.now().millisecondsSinceEpoch}.png');

      await storageReference.putFile(File(imageFile.path));

      final String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      log('Error uploading image: $error');
      return '';
    }
  }

  final List<Student> _filteredStudents = [];
  List<Student> get filteredStudents => _filteredStudents;

  Future<void> filterStudentsByAgeRange(int minAge, int maxAge) async {
    try {
      final query = FirebaseFirestore.instance
          .collection('students')
          .where('age', isGreaterThanOrEqualTo: minAge)
          .where('age', isLessThanOrEqualTo: maxAge);

      final snapshot = await query.get();

      _filteredStudents.clear();

      final students =
          snapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
      _filteredStudents.addAll(students);
    } catch (error) {
      log('Error filtering students by age range: $error');
    }
    notifyListeners();
  }

  final List<Student> _searchResults = [];
  List<Student> get searchedResult => _searchResults;

  Future<void> searchStudentsByName(String name) async {
    try {
      final query = FirebaseFirestore.instance
          .collection('students')
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThan: '$name\uf8ff');

      final snapshot = await query.get();
      _searchResults.clear();
      final students =
          snapshot.docs.map((doc) => Student.fromSnapshot(doc)).toList();
      _searchResults.addAll(students);
    } catch (error) {
      log('Error searching students: $error');
    }
    notifyListeners();
  }

  Future<void> deleteStudent(String studentId, String photoUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .delete();

      final photoReference = FirebaseStorage.instance.refFromURL(photoUrl);
      await photoReference.delete();

      log('Student and associated image deleted successfully!');
    } catch (error) {
      log('Error deleting student: $error');
    }
    notifyListeners();
  }

  Future<void> updateStudent(
      String studentId, String name, int age, String photoUrl) async {
    try {
      final documentReference =
          FirebaseFirestore.instance.collection('students').doc(studentId);

      final student = Student(
        id: studentId,
        name: name,
        age: age,
        photoUrl: photoUrl,
      );

      await documentReference.update(student.toMap());

      log('Student updated successfully!');
    } catch (error) {
      log('Error updating student: $error');
    }
    notifyListeners();
  }
}
