import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String? uid;
  final String fullNames;
  final String email;
  final String jumuiya;

  Member(
      {required this.uid,
      required this.fullNames,
      required this.email,
      required this.jumuiya});

  factory Member.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    final docData = doc.data();
    return Member(
        uid: docData!['uid'],
        fullNames: docData['fullNames'],
        email: docData['email'],
        jumuiya: docData['jumuiya']);
  }

  Map<String, String> toFirestore() {
    return {
      if (uid != null) 'uid': uid!,
      'fullNames': fullNames,
      'email': email,
      'jumuiya': jumuiya,
    };
  }
}
