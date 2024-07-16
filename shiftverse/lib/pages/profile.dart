import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              'Account Details',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),

            //Profile Picture and Account info

            Row(
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 70,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mark Thomas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'St. Sylvester',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text('markthomaskahiga@gmail.com'),
                  ],
                )
              ],
            ),

            // Edit details section
            const SizedBox(height: 15),
            Text(
              'Edit your details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 15),
            const Text('Coming Soon'),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  context.go('/');
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    ));
  }
}
