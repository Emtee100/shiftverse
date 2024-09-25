import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/profile_card.dart';
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
            ElevatedButton(
                onPressed: () async {
                  String? token = await FirebaseMessaging.instance.getToken();
                  print(token);
                  // try {
                  //   await FirebaseFunctions.instance
                  //       .httpsCallable('sendShiftNotification')
                  //       .call(<String, String?>{
                  //     "token": token,
                  //   }).then((result) {
                  //     print(result);
                  //   });
                  // } on FirebaseFunctionsException catch (error) {
                  //   print(error.code);
                  //   print(error.details);
                  //   print(error.message);
                  // }
                  // FirebaseAuth.instance.signOut();
                  // context.go('/');
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    ));
  }
}
