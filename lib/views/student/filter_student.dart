import 'package:checkout/views/student/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student.dart';
import '../../viewmodels/student_viewmodel.dart';

class StudentFilterPage extends StatefulWidget {
  const StudentFilterPage({super.key});

  @override
  State<StudentFilterPage> createState() => _StudentFilterPageState();
}

class _StudentFilterPageState extends State<StudentFilterPage> {
  final _formKey = GlobalKey<FormState>();
  double _minAge = 0.0;
  double _maxAge = 110.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Students'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RangeSlider(
                labels: RangeLabels(
                  _minAge.floor().toString(),
                  _maxAge.floor().toString(),
                ),
                values: RangeValues(_minAge, _maxAge),
                min: 0.0,
                max: 110.0,
                divisions: 50,
                onChanged: (values) {
                  setState(() {
                    _minAge = values.start;
                    _maxAge = values.end;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Minimum Age: ${_minAge.toInt()}'),
                  Text('Maximum Age: ${_maxAge.toInt()}'),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await Provider.of<StudentViewModel>(context, listen: false)
                      .filterStudentsByAgeRange(
                          _minAge.toInt(), _maxAge.toInt());
                },
                child: const Text('Filter Students'),
              ),
              const SizedBox(height: 16.0),
              Consumer<StudentViewModel>(
                builder: (context, model, child) {
                  if (model.filteredStudents.isEmpty) {
                    return const Text('No students to display');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: model.filteredStudents.length,
                        itemBuilder: (context, index) {
                          Student student = model.filteredStudents[index];
                          return StudentCard(student: student);
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
