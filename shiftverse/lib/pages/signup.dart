import 'package:flutter/material.dart';
import 'package:shiftverse/widgets/sign_up_landscape.dart';
import 'package:shiftverse/widgets/sign_up_portrait.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isMoreWideThanTall = constraints.maxWidth > constraints.maxHeight;
      if (isMoreWideThanTall) {
        return const SignUpLandscape();
      } else {
        return const SignUpPortrait();
      }
    });
  }
}
