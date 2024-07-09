import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shiftverse/pages/homepage.dart';
import 'package:shiftverse/widgets/email_verification.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // this widget checks if the user's email is verified
    // if it is, it will take the user to the homepage else
    // it will show the screen telling the user to check their mail
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser?.reload(), 
      builder: (context, snapshot){
        if(FirebaseAuth.instance.currentUser?.emailVerified == true){
          return const Homepage();
        } else {
          return const EmailVerification();
        }
      });
  }
}