import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              )),
          const SizedBox(height: 20),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              )),
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
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    icon: isConfirmPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
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
              child: const Text('Sign up'))
        ],
      )),
    );
  }
}
