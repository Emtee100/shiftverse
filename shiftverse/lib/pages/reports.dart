import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/all_sales_report.dart';
import 'package:shiftverse/widgets/sale_report_form.dart';
import 'package:shiftverse/widgets/sales_charts.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 15),
              Text(
                'Sales Report',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 15),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Monthly Pamphlet Sales',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, left: 5, right: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20)),
                height: 300,
                //width: 300,
                child: ChangeNotifierProvider(
                    create: (context) => FirebaseController(),
                    child: const ChartSales()),
              ),
              const SizedBox(height: 15),
              Text(
                'Sales',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ]),
          )),
          ChangeNotifierProvider(
              create: (context) => FirebaseController(),
              child: const AllSalesReport()),
        ]),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              tooltip: 'Add a sales report',
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerLow,
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            //const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sale Report',
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ChangeNotifierProvider(
                                create: (context) => FirebaseController(),
                                child: const SaleReportForm())
                          ],
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
