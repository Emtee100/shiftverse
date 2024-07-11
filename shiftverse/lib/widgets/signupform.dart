import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/firebaseController.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _jumuiyaController;
  late final TextEditingController _nameController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _jumuiyaController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _jumuiyaController.dispose();
    _confirmPasswordController.dispose();
  }

  List<DropdownMenuEntry> jumuiya = const [
    DropdownMenuEntry(label: 'St. Perpetua', value: "St. Perpetua"),
    DropdownMenuEntry(label: 'St. Mercelino', value: "St. Mercelino"),
    DropdownMenuEntry(label: 'St. Sylvester', value: 'St. Sylvester'),
    DropdownMenuEntry(label: 'Brother', value: 'Brother'),
    DropdownMenuEntry(label: 'Sister', value: 'Sister'),
  ];
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  //this key is used to uniquely identify the sign up form and
  // help in validation of the contents of the form
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseContorller>(builder: (context, value, child) {
      //String errorCode = value.errorCode;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Full Names',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
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
                DropdownMenu(
                  menuStyle: MenuStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  expandedInsets: EdgeInsets.zero,
                  dropdownMenuEntries: jumuiya,
                  controller: _jumuiyaController,
                  hintText: 'Jumuiya',
                  initialSelection: 'St.Sylvester',
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: isPasswordVisible ? false : true,
                  keyboardType: TextInputType.text,
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
                      return 'Please enter a password';
                    } else if (value != _confirmPasswordController.text) {
                      return 'Value in password should match with value in confirm password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: isConfirmPasswordVisible ? false : true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                        icon: isConfirmPasswordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value != _passwordController.text) {
                      return 'The two passwords should match';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                FilledButton(
                    style: const ButtonStyle(
                        minimumSize:
                            WidgetStatePropertyAll(Size(double.infinity, 40))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String? errorCode = await value.signUp(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                        //print(value.errorCode);
                        switch (errorCode) {
                          case null:
                            if (context.mounted) {
                              context.go('/email-verification');
                            }
                            break;
                          case 'email-already-in-use':
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
                                        'The email provided is being used by an another user, please use another email'),
                                    title: const Text('Email already in use'),
                                  );
                                });
                            break;
                          case 'weak-password':
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
                                        'You have provided a weak password. Please provide a stronger password to continue'),
                                    title: const Text('Weak Password'),
                                  );
                                });
                            break;
                          case 'invalid-email':
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
                                        'The email provided is not invalid and poorly formatted as an email, please enter a proper email'),
                                    title: const Text('Invalid Email'),
                                  );
                                });
                            break;
                          default:
                        }
                      }
                    },
                    child: const Text('Sign up'))
              ],
            )),
      );
    });
  }
}
