import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'ShiftVerse',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 240),
              child: Text('Already have an account? Sign in',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface))),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Full Names',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                DropdownMenu(
                  menuStyle: MenuStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  expandedInsets: EdgeInsets.zero,
                  dropdownMenuEntries: jumuiya,
                  controller: _jumuiyaController,
                  hintText: 'Jumuiya',
                ),
                const SizedBox(height: 20),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                    child: const Text('Sign up'))
              ],
            )),
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Already have an account?',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
            GestureDetector(
              onTap: () {
                context.go('/signin');
              },
              child: RichText(
                  text: TextSpan(
                      text: 'Sign in',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary))),
            )
          ])
        ])));
  }
}
