import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
        builder: (context, value, child) => ElevatedButton(
            onPressed: (){
              value.signOut();
              context.go("/");
            },
            child: Text(
              "Sign out",
              style: Theme.of(context).textTheme.bodyMedium,
            )));
  }
}
