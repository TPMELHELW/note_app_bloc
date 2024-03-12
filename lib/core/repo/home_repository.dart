import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:note_app_bloc/core/database/crud.dart';

class HomeRepository {
  // List<QueryDocumentSnapshot> data = [];
  Crud crud = Crud();

  getNotes(String type) async {
    final ref = await FirebaseFirestore.instance
        .collection('notes')
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where(
          'type',
          isEqualTo: type,
        )
        .orderBy('time', descending: true)
        .get();

    return ref.docs;
  }

  Future<void> addData(
    String title,
    String body,
    String selected,
  ) async {
    DateTime now = DateTime.now();

    await crud.insertData(
      "INSERT INTO 'notes' ('title','body','type')  VALUES('$title','$body','$selected') ",
    );
    await FirebaseFirestore.instance.collection("notes").add({
      'title': title,
      'body': body,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      "time": DateFormat('yyy-MM-dd HH:mm:ss').format(now),
      'type': selected,
    });
  }

  Future<void> editData(String title, String body, String noteId) async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance.collection('notes').doc(noteId).update({
      'title': title,
      'body': body,
      "time": DateFormat('yyy-MM-dd HH:mm:ss').format(now),
    });
  }
}
