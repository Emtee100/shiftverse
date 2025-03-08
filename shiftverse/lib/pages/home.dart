import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/controllers/sheetsController.dart';
import 'package:shiftverse/widgets/recent_sales.dart';
import 'package:shiftverse/widgets/sales_charts.dart';
import 'package:shiftverse/widgets/upcoming_shifts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Check whether existing user record has the fcmToken and tokenTimestamp fields and update them if they don't exist
    FirebaseController().hasFcmTokenAndTimestamp();
    //final name = FirebaseController().getUserRecord();
    // Ensure that the device token gotten from the device and the one in the database are the same
    FirebaseController().updateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            ChangeNotifierProvider(
                create: (context) => FirebaseController(),
                builder: (context, value) {
                  return Consumer<FirebaseController>(
                      builder: (context, value, child) {
                    return FutureBuilder(
                        future: value.getUserRecord(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("");
                          } else {
                            final String user =
                                snapshot.data!.data()!.fullNames;
                            return Text(
                              "Hi $user",
                              style: Theme.of(context).textTheme.headlineMedium,
                            );
                          }
                        });
                  });
                }),

            //Chart section
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Monthly Pamphlet Sales',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            Container(
              padding:
                  const EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20)),
              height: 300,
              //width: 300,
              child: ChangeNotifierProvider(
                  create: (context) => FirebaseController(),
                  child: const ChartSales()),
            ),

            //Recent Sales section

            Text(
              'Recent Sales',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            ChangeNotifierProvider(
                create: (context) => FirebaseController(),
                child: const RecentSales()),

            //Upcoming shifts

            Text(
              'Upcoming Shifts',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            ChangeNotifierProvider(
                create: (context) => SheetsController(),
                child: const UpcomingShifts())
          ],
        ),
      ),
    ));
  }
}
