import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;

  Task(
      {required this.id,
      required this.title,
      required this.completed,
      required this.createdAt});

  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      title: doc['title'],
      completed: doc['completed'],
      createdAt: (doc['created_at'] as Timestamp).toDate(),
    );
  }
}
