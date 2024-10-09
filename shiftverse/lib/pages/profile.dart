import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/profile_card.dart';
import 'package:shiftverse/widgets/sign_out_button.dart';
//import 'package:http/http.dart' as http;

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
                const Icon(
                  Icons.account_circle_rounded,
                  size: 70,
                ),
                const SizedBox(
                  width: 20,
                ),
                ChangeNotifierProvider(
                  create: (context) => FirebaseController(),
                  builder: (context, child) => const ProfileCard(),
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
            ChangeNotifierProvider(
              create: (context)=>FirebaseController(),
              child: SignOutButton())
          ],
        ),
      ),
    ));
  }
}