import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shiftverse/Routes/router.dart';
import 'package:shiftverse/Themes/theme.dart';
import 'package:shiftverse/firebase_options.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: NavigationLogic().router,
      debugShowCheckedModeBanner: false,
      title: 'ShiftVerse',
      darkTheme: SVtheme.darkTheme,
      theme: SVtheme.lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}