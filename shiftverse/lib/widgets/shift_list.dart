import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/sheetsController.dart';

class ShiftList extends StatefulWidget {
  const ShiftList({super.key});

  @override
  State<ShiftList> createState() => _ShiftListState();
}

class _ShiftListState extends State<ShiftList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SheetsController>(
        builder: (context, value, child) => SizedBox(
              height: 700,
              child: FutureBuilder(
                future: value.retrieveShiftData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Leaders on duty:'),
                                  Text(
                                    snapshot.data![index][2],
                                  ),
                                  Text(
                                    snapshot.data![index][3],
                                  ),
                                  Text(
                                    'Date: ${snapshot.data![index][0]}',
                                  ),
                                  Text('Jumuiya: ${snapshot.data![index][4]}'),
                                ],
                              ));
                        });
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('An error occurred while retrieving data'));
                  } else {
                    return const Text('Null');
                  }
                },
              ),
            ));
  }
}
