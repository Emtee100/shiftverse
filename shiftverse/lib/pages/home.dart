import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
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

            const Placeholder(
              fallbackHeight: 150,
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
                          title: const Text('Pamphlets sold: 4650'),
                          subtitle: const Text('Remaining pamphlets: 50'),
                        ),
                      );
                    })),
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
