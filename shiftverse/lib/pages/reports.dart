import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/sale_report_form.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            const Placeholder(
              fallbackHeight: 150,
            ),
            const SizedBox(height: 15),
            Text(
              'Sales',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
                height: 300,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          leading: const Icon(Icons.contact_page),
                          title: const Text('Pamphlets sold: 4650'),
                          subtitle: const Text('Remaining pamphlets: 50'),
                        ),
                      );
                    })),
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a sales report',
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
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
                      const SizedBox(height: 15,),
                      ChangeNotifierProvider(
                        create: (context)=> FirebaseContorller(),
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
    );
  }
}
