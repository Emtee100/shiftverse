import 'package:flutter/material.dart';
import 'package:shiftverse/widgets/sign_in_landscape.dart';
import 'package:shiftverse/widgets/sign_in_portrait.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > constraints.maxHeight) {
        return const SignInLandscape();
      } else {
        return const SignInPortrait();
      }
    }));
  }
}
