import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/recent_sales.dart';
import 'package:shiftverse/widgets/sales_charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              'Hi, Mark Thomas',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 15,
            ),

            //Chart section
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

            const SizedBox(
              height: 15,
            ),

            //Recent Sales section

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Sales',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(onPressed: () {}, child: const Text('See all'))
              ],
            ),

            ChangeNotifierProvider(
                create: (context) => FirebaseController(),
                child: const RecentSales()),

            const SizedBox(
              height: 15,
            ),

            //Upcoming shifts

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Shifts',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(onPressed: () {}, child: const Text('See all'))
              ],
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
                            tileColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            leading: const Icon(Icons.contact_page),
                            title: const Text('Jumuiya: St.Sylvester'),
                            subtitle: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mark Thomas'),
                                Text('Mary Akinyi')
                              ],
                            )),
                      );
                    })),
          ],
        ),
      ),
    ));
  }
}
