import 'package:go_router/go_router.dart';
import 'package:shiftverse/pages/authpage.dart';
import 'package:shiftverse/pages/email_verification_screen.dart';
import 'package:shiftverse/pages/homepage.dart';
import 'package:shiftverse/pages/resetpassword.dart';
import 'package:shiftverse/pages/signin.dart';
import 'package:shiftverse/pages/signup.dart';

class NavigationLogic {
  final GoRouter _router = GoRouter(routes: [
    // Authpage. Authpage will be our home since it
    //will verify whether a user has signed in or not

    GoRoute(path: '/', builder: (context, state) => const Authpage(), routes: [
      // sign up route.
      // we're putting this route in the home route
      // to ensure that when we click on Signup button
      // we can use the push() method to go to the Sign up screen
      GoRoute(path: 'signup', builder: (context, state) => const SignupPage()),
      // forgot password route

      GoRoute(
          path: 'password-reset',
          builder: (context, state) => const PasswordReset()),
    ]),

    // sign in route

    GoRoute(path: '/signin', builder: (context, state) => const SignInPage()),

    GoRoute(
      path: '/home',
      builder: (context, state) => const Homepage(),
    ),

    GoRoute(
        path: '/email-verification',
        builder: (context, state) => const EmailVerificationScreen())
    //
  ]);

  get router => _router;
}
