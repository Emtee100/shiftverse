import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
        builder: (context, value, child) => FutureBuilder(
            future: value.getUserRecord(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // ignore: unnecessary_string_interpolations
                      '${snapshot.data!.data()!.fullNames}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // Text(
                    //   'St. Sylvester',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodyMedium!
                    //       .copyWith(color: Theme.of(context).colorScheme.onSurface),
                    // ),
                    Text('${snapshot.data?.data()?.email}'),
                  ],
                );
              }
            }));
  }
}
