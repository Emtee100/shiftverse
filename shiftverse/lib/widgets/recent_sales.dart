import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class RecentSales extends StatefulWidget {
  const RecentSales({super.key});

  @override
  State<RecentSales> createState() => _RecentSalesState();
}

class _RecentSalesState extends State<RecentSales> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
        builder: (context, value, child) => StreamBuilder(
            stream: value.getSaleRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 330,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return SizedBox(
                    height: 330,
                    child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((doc) {
                          final String formattedDate = DateFormat('dd-MM-yyyy')
                              .format(doc['saleDate'].toDate());
                          return ListTile(
                            leading: const Icon(Icons.wallet),
                            title: Text('Pamphlets sold: ${doc['saleAmount']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Remaining pamphlets: ${doc['pamphletsLeft']}'),
                                Text('Date sold: $formattedDate')
                              ],
                            ),
                          );
                        }).toList()));
              } else if (snapshot.hasError) {
                return Text(
                  'Error in obtaining sales',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                );
              } else {
                return const Text('null');
              }
            }));
  }
}
