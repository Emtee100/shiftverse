import 'package:flutter/material.dart';
import 'package:shiftverse/widgets/reset_email_form.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ShiftVerse',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text('Enter your email to reset your password',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface))),
          const SizedBox(height: 20),
          const ResetEmailForm()
        ],
      ),
    ));
  }
}
