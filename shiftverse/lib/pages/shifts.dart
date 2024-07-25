import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/sheetsController.dart';
import 'package:shiftverse/widgets/filters.dart';

class Shifts extends StatelessWidget {
  const Shifts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              'Shifts',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),
            ChangeNotifierProvider(
                create: (context) => SheetsController(),
                child: const Filters()),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }
}
