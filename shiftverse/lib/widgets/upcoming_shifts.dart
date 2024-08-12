import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/sheetsController.dart';

class UpcomingShifts extends StatefulWidget {
  const UpcomingShifts({super.key});

  @override
  State<UpcomingShifts> createState() => _UpcomingShiftsState();
}

class _UpcomingShiftsState extends State<UpcomingShifts> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SheetsController>(
      builder: (context, value, child) => FutureBuilder(
        future: value.retrieveShiftData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
                height: 380, child: Center(child: CircularProgressIndicator()));
          } else {
            return SizedBox(
              height: 380,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ListTile(
                      tileColor:
                          Theme.of(context).colorScheme.surfaceContainerHigh,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      leading: const Icon(Icons.access_time),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Leaders on duty'),
                          Row(
                            children: [
                              Text('1. ${snapshot.data![index][2]}'),
                              const SizedBox(width: 10),
                              Text('2. ${snapshot.data![index][3]}'),
                            ],
                          ),
                          Text('Date: ${snapshot.data![index][0]}')
                        ],
                      ),
                      subtitle: Text('Jumuiya: ${snapshot.data![index][4]}'),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
