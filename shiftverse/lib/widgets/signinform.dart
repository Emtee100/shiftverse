import 'package:flutter/material.dart';

class Signinform extends StatefulWidget {
  const Signinform({super.key});

  @override
  State<Signinform> createState() => _SigninformState();
}

class _SigninformState extends State<Signinform> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
          child: Column(
        children: [
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              )),
          const SizedBox(height: 20),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordController,
              obscureText: isPasswordVisible ? false : true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {}, child: const Text("Forgot password?")),
          ),
          FilledButton(
              style: const ButtonStyle(
                  minimumSize:
                      WidgetStatePropertyAll(Size(double.infinity, 40))),
              onPressed: () {},
              child: const Text('Sign in'))
        ],
      )),
    );
  }
}
