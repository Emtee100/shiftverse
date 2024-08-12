import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  final String? uid;
  final double saleAmount;
  final double pamphletsLeft;
  final DateTime saleDate;

  Sale(
      {required this.uid,
      required this.saleAmount,
      required this.pamphletsLeft,
      required this.saleDate});

  factory Sale.fromFirestore(DocumentSnapshot<Map<String, dynamic>> saleDoc,
      SnapshotOptions? options) {
    final saleData = saleDoc.data();
    return Sale(
      uid: saleData!['uid'],
      saleAmount: (saleData['saleAmount']).toDouble(),
      pamphletsLeft: (saleData['pamphletsLeft']).toDouble(),
      saleDate: (saleData['saleDate']).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid!,
      'saleAmount': saleAmount,
      'pamphletsLeft': pamphletsLeft,
      'saleDate': saleDate,
    };
  }
}
