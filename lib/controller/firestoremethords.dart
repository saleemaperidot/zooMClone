import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firestoreMethords {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> get history => _firebaseFirestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings')
      .snapshots();

  void addToMeetingHistory(String MeetingName) {
    _firebaseFirestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('meetings')
        .add({
      'meetingName': MeetingName,
      'createdAt': DateTime.now(),
    });
    try {} catch (e) {
      print(e);
    }
  }
}
