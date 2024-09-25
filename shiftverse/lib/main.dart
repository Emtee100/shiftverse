import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shiftverse/Routes/router.dart';
import 'package:shiftverse/Themes/theme.dart';
import 'package:shiftverse/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.debug);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  //request permission from the user
  final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(
          provisional: true, announcement: true, criticalAlert: true);
  // create a local notification channel and listen for notifications from FCM servers
  // once the permission has been granted
  if (notificationSettings.authorizationStatus ==
      AuthorizationStatus.authorized) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('play_store_512');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    const _notificationChannel = AndroidNotificationChannel(
        'shiftVerse_channel', 'ShiftVerse_foreground_channel',
        importance: Importance.high);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannel);

    //listen to messages(notifications) from FCM servers and assign them to our local notification channel for display
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        // create a android notification details class and NotificationDetails class to define
        // details of an individual notification
        const AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
                'shiftVerse_channel', 'ShiftVerse_foreground_channel',
                importance: Importance.high,
                priority: Priority.high,
                ticker: 'ticker',
                icon: 'play_store_512');
        const NotificationDetails _notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            _notificationDetails);
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
