import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class AllSalesReport extends StatefulWidget {
  const AllSalesReport({super.key});

  @override
  State<AllSalesReport> createState() => _AllSalesReportState();
}

class _AllSalesReportState extends State<AllSalesReport> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
        builder: (context, value, child) => StreamBuilder(
            stream: value.getSaleRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                    child: const Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasData) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: snapshot.data!.docs.length,
                        (context, index) {
                  List<String> formattedDates = [];
                  for (final doc in snapshot.data!.docs) {
                    final String formattedDate = DateFormat('dd-MM-yyyy')
                        .format(doc['saleDate'].toDate());
                    formattedDates.add(formattedDate);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        leading: const Icon(Icons.wallet),
                        title: Text(
                            'Pamphlets sold: ${snapshot.data!.docs[index]['saleAmount']}'),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Remaining pamphlets: ${snapshot.data!.docs[index]['pamphletsLeft']}'),
                              Text('Date sold: ${formattedDates[index]}'),
                            ])),
                  );
                }));
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
