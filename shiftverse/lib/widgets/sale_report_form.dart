import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class SaleReportForm extends StatefulWidget {
  const SaleReportForm({super.key});

  @override
  State<SaleReportForm> createState() => _SaleReportFormState();
}

class _SaleReportFormState extends State<SaleReportForm> {
  late final TextEditingController _saleAmountController;
  late final TextEditingController _pamphletsLeftController;
  late final TextEditingController _saleDateController;

  @override
  void initState() {
    super.initState();
    _saleAmountController = TextEditingController();
    _pamphletsLeftController = TextEditingController();
    _saleDateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _saleAmountController.dispose();
    _pamphletsLeftController.dispose();
    _saleDateController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool isDateSelected = false;
  late DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseContorller>(
      builder: (context, value, child) => Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _saleAmountController,
                decoration: InputDecoration(
                    labelText: 'Amount Sold',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount sold';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _pamphletsLeftController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Remaining pamphlets',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of pamphlets remaining';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  final firstDate =
                      DateTime.now().subtract(const Duration(days: 14));
                  final lastDate = DateTime.now().add(const Duration(days: 14));
                  pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(
                        firstDate.year, firstDate.month, firstDate.day),
                    lastDate: lastDate,
                    barrierDismissible: false,
                    initialDatePickerMode: DatePickerMode.day,
                    initialDate: DateTime.now(),
                    switchToCalendarEntryModeIcon:
                        const Icon(Icons.calendar_month),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      isDateSelected = true;
                    });
                    _saleDateController.text = pickedDate.toString();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          isDateSelected
                              ? '${pickedDate!.year}-${pickedDate!.month}-${pickedDate!.day}'
                              : 'Select sale date',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: isDateSelected
                                      ? Colors.white
                                      : Colors.grey[200])),
                      const Icon(Icons.calendar_month_rounded)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FilledButton(
                  style: const ButtonStyle(
                      minimumSize:
                          WidgetStatePropertyAll(Size(double.infinity, 40))),
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      value.createSaleEntry(amountSold: _saleAmountController.text, pamphletsLeft: _pamphletsLeftController.text, saleDate: pickedDate!);
                    }
                  },
                  child: const Text('Submit'))
            ],
          )),
    );
  }
}
