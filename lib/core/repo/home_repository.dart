import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeRepository {
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

  Future<void> addData(String title, String body, String selected) async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance.collection("notes").add({
      'title': title,
      'body': body,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      "time": DateFormat('yyy-MM-dd HH:mm:ss').format(now),
      'type': selected,
    });
  }
}
