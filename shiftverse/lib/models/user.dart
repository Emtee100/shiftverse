import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String? userId;
  final String fullNames;
  final String email;
  final String jumuiya;
  final String? fcmToken;
  final Timestamp tokenTimestamp;

  Member({
    required this.userId,
    required this.fullNames,
    required this.email,
    required this.jumuiya,
    required this.fcmToken,
    required this.tokenTimestamp
  });

  factory Member.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    final docData = doc.data();
    return Member(
        userId: docData!['userId'],
        fullNames: docData['fullNames'],
        email: docData['email'],
        jumuiya: docData['jumuiya'],
        fcmToken: docData['fcmToken'],
        tokenTimestamp: docData['tokenTimestamp']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null && fcmToken != null) 'userId': userId!,
      'fullNames': fullNames,
      'email': email,
      'jumuiya': jumuiya,
      'fcmToken': fcmToken!,
      'tokenTimestamp': tokenTimestamp
    };
  }
}
