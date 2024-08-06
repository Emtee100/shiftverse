import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/sheetsController.dart';
import 'package:shiftverse/widgets/filters.dart';

class Shifts extends StatelessWidget {
  const Shifts({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SheetsController(), child: const Filters());
  }
}
