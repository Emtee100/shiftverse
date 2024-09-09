import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shiftverse/Routes/router.dart';
import 'package:shiftverse/Themes/theme.dart';
import 'package:shiftverse/firebase_options.dart';

@pragma('vm:entry-point')
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug
    );
  FlutterError.onError = (errorDetails){
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error,stack){
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true,announcement: true,criticalAlert: true);
  if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('Got a message whilst in the foreground!');
      print("Message is: ${message.data}");
      if(message.notification != null){
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }else{
    print('User has not yet granted permission');
    //await FirebaseMessaging.instance.requestPermission(provisional: true,announcement: true,criticalAlert: true);
  }
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