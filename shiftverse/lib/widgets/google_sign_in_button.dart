import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/google.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Sign in with Google')
        ],
      ),
    );
  }
}
