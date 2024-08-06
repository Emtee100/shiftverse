import 'package:flutter/material.dart';
import 'package:shiftverse/controllers/sheetsController.dart';

class ShiftList extends StatefulWidget {
  const ShiftList({super.key, required this.sheet});
  final SheetsController sheet;

  @override
  State<ShiftList> createState() => _ShiftListState();
}

class _ShiftListState extends State<ShiftList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.sheet.filterByJumuiya(widget.sheet.selectedjumus),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data!.isEmpty) {
          return const Text('Select a filter to view shifts');
        } else if (snapshot.hasData) {
          return SliverList.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ListTile(
                          leading: const Icon(Icons.access_time),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHigh,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Leaders on duty:'),
                              Row(
                                children: [
                                  Text(
                                    '1. ${snapshot.data![index][2]}',
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '2. ${snapshot.data![index][3]}',
                                  ),
                                ],
                              ),
                              Text(
                                'Date: ${snapshot.data![index][0]}',
                              ),
                              Text('Jumuiya: ${snapshot.data![index][4]}'),
                            ],
                          )),
                    ));
              });
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('An error occurred while retrieving data'));
        } else {
          return const Text('Null');
        }
      },
    );
  }
}
