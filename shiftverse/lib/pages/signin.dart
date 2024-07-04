import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password?")),
                    ),
                    FilledButton(
                        style: const ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(
                                Size(double.infinity, 40))),
                        onPressed: () {},
                        child: const Text('Sign in'))
                  ],
                )),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Or'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/google.svg',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Sign in with Google')
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface)),
                  GestureDetector(
                    onTap: (){
                      context.push('/signup');
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Sign up',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary))),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
