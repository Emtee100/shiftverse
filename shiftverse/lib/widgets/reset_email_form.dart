import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

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
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Consumer<FirebaseController>(
        builder: (context, value, child) => Padding(
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
                              minimumSize: WidgetStatePropertyAll(
                                  Size(double.infinity, 40))),
                          onPressed: () async {
                            // the if statements checks the validator function of the textformfield
                            // if they return null, the form is valid and the password reset email is sent
                            if (_resetPasswordformKey.currentState!
                                .validate()) {
                              String? errorCode = await value
                                  .resetPassword(_emailController.text.trim());
                              if (errorCode == 'invalid-email') {
                                showDialog(
                                    context: context,
                                    builder: (
                                      context,
                                    ) {
                                      return AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'OK',
                                              ))
                                        ],
                                        content: const Text(
                                            'The email provided is invalid, please use another email'),
                                        title: const Text('Email is invalid'),
                                      );
                                    });
                              } else if (errorCode == null) {
                                showModalBottomSheet(
                                    isDismissible: false,
                                    showDragHandle: true,
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                          height: screenHeight / 2,
                                          width: screenWidth,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                height: 60,
                                                width: 60,
                                                child: Icon(
                                                  Icons.email_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Check your email',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 300),
                                                child: const Text(
                                                  'We have sent instructions to reset your password to your email',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context.go('/');
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child:
                                                      const Text('OK, got it'),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              }
                            }
                          },
                          child: const Text('Send reset email'))
                    ],
                  )),
            ));
  }
}
