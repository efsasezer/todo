import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id; // Görev ID'si
  final String title; // Görev başlığı
  final bool completed; // Görev tamamlanmış mı
  final DateTime createdAt; // Görevin oluşturulma tarihi

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
  });

  // Firestore'dan alınan belgeyi Task modeline dönüştüren fabrika metodu
  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id, // Belgedeki ID
      title: doc['title'], // Belgedeki başlık
      completed: doc['completed'], // Belgedeki tamamlanma durumu
      createdAt: (doc['created_at'] as Timestamp)
          .toDate(), // Belgedeki oluşturulma tarihini DateTime'e dönüştür
    );
  }
}
