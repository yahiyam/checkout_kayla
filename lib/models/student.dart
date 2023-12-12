import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final int age;
  final String photoUrl;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.photoUrl,
  });

  factory Student.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Student(
      id: snapshot.id,
      name: data['name'] as String,
      age: data['age'] as int,
      photoUrl: data['photoUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'photoUrl': photoUrl,
    };
  }
}
