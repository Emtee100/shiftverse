import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';
import 'package:shiftverse/widgets/google_sign_in_button.dart';
import 'package:shiftverse/widgets/signinform.dart';

class SignInLandscape extends StatelessWidget {
  const SignInLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ShiftVerse',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: Text('Already have an account? Sign in',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface))),
                const SizedBox(height: 20),
            
                const SizedBox(
                  height: 20,
                ),
                // google sign in button
                // GoogleSignInButton(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            // Form to collect email and password
            // Signinform(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChangeNotifierProvider(
                  create: (context)=>FirebaseController(),
                  child: const Signinform()),
                const SizedBox(
                  height: 20,
                ),
              
                // google sign in button
              
                ChangeNotifierProvider(
                  create: (context) => FirebaseController(),
                  child: const GoogleSignInButton()),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface)),
                    GestureDetector(
                      onTap: () {
                        context.push('/signup');
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
                        ),
                      ),
            )),
      ]),
    ));
  }
}
