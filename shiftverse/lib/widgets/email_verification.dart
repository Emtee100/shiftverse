import 'package:flutter/material.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 60,
              width: 60,
              child:  Icon(Icons.email_rounded,color: Theme.of(context).colorScheme.onPrimaryContainer,),

            ),
            const SizedBox(height: 20,),
            Text('Verification email sent!',style: Theme.of(context).textTheme.titleLarge,),
            const Text('Please check your email to verify your account'),
          ],
        )
      ),
    );
  }
}