import 'package:flutter/material.dart';

class ResetEmailForm extends StatefulWidget {
  const ResetEmailForm({super.key});

  @override
  State<ResetEmailForm> createState() => _ResetEmailFormState();
}

class _ResetEmailFormState extends State<ResetEmailForm> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  final _resetPasswordformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
          key: _resetPasswordformKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                  style: const ButtonStyle(
                      minimumSize:
                          WidgetStatePropertyAll(Size(double.infinity, 40))),
                  onPressed: () {
                    // the if statements checks the validator functions of the textformfields
                    // if they return null, the form is valid and the user can sign in
                    if (_resetPasswordformKey.currentState!.validate()) {
                      // value.signIn(_emailController.text.trim(),
                      //     _emailController.text.trim());
                    }
                  },
                  child: const Text('Send reset email'))
            ],
          )),
    );
  }
}
