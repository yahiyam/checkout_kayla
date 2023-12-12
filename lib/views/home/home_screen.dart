import 'package:checkout/utils/functions/next_screen.dart';
import 'package:checkout/viewmodels/auth/auth_email_sign_up.dart';
import 'package:checkout/viewmodels/auth/auth_google.dart';
import 'package:checkout/viewmodels/auth/auth_phone.dart';
import 'package:checkout/viewmodels/student_viewmodel.dart';
import 'package:checkout/views/auth/login_page.dart';
import 'package:checkout/views/student/add_student.dart';
import 'package:checkout/views/student/filter_student.dart';
import 'package:checkout/views/student/search_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student.dart';
import '../student/widgets/student_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gAP = Provider.of<AuthGoogleProvider>(context);
    final pAP = Provider.of<AuthPhoneProvider>(context);
    final eAP = Provider.of<AuthEmailSignUpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(context: context, page: const StudentFilterPage());
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          IconButton(
            onPressed: () {
              nextScreen(context: context, page: const StudentSearch());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              pAP.userSignOut();
              gAP.userSignOut();
              eAP.userSignOut();
              nextScreenReplace(context: context, page: const LoginScreen());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<StudentViewModel>(
          builder: (context, model, child) {
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('students').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.blueGrey,
                          size: 150,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No students available',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  final students = snapshot.data!.docs
                      .map((doc) => Student.fromSnapshot(doc))
                      .toList();

                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      Student student = students[index];
                      return StudentCard(
                        student: student,
                        showDelete: true,
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          nextScreen(
            context: context,
            page: const AddStudentPage(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
