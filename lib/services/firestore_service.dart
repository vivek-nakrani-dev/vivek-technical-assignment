import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vivek_technical_assignment/models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Note>> getNotes() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }
    return _db
        .collection('NOTES')
        .where('USER_ID', isEqualTo: userId)
        .orderBy('CREATED_AT', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Note.fromRecord(doc.data(), doc.id)).toList());
  }

  Future<void> addNote({required String title, required String content}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("User not found.");
    }

    final id = FirebaseFirestore.instance.collection('NOTES').doc().id;

    await _db.collection('NOTES').doc(id).set({
      'ID': id,
      'TITLE': title,
      'CONTENT': content,
      'USER_ID': userId,
      'CREATED_AT': Timestamp.now(),
      'UPDATED_AT': Timestamp.now(),
    });
  }

  Future<void> updateNote({required String id, required String title, required String content}) async {
    await _db.collection('NOTES').doc(id).update({'TITLE': title, 'CONTENT': content, 'UPDATED_AT': Timestamp.now()});
  }

  Future<void> deleteNote({required String id}) async {
    await _db.collection('NOTES').doc(id).delete();
  }
}
