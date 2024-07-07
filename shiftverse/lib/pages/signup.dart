import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shiftverse/widgets/signupform.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Center(
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
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface))),
                    const SizedBox(height: 20),
                    const SignUpForm(),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                      GestureDetector(
                        onTap: () {
                          context.go('/signin');
                        },
                        child: RichText(
                            text: TextSpan(
                                text: 'Sign in',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))),
                      )
                    ])
                  ]),
            ),
          ),
        ));
  }
}
