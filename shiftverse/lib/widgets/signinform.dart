import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

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

  //this key is used to uniquely identify the sign in form and
  // help in validation of the contents of the form
  final _emailSigninformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // the consumer widget is used to listen to the value of the
    // provider and rebuild the widget when the value changes
    return Consumer<FirebaseContorller>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            key: _emailSigninformKey,
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        context.push('/password-reset');
                      }, child: const Text("Forgot password?")),
                ),
                FilledButton(
                    style: const ButtonStyle(
                        minimumSize:
                            WidgetStatePropertyAll(Size(double.infinity, 40))),
                    onPressed: () {
                      // the if statements checks the validator functions of the textformfields
                      // if they return null, the form is valid and the user can sign in
                      if (_emailSigninformKey.currentState!.validate()) {
                        value.signIn(_emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    child: const Text('Sign in'))
              ],
            )),
      ),
    );
  }
}
