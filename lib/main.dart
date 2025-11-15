import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/screens/home_screen.dart';

FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
   When U went To Work with 'Time Zone Scheduling' then we import
   below function And import 'package:timezone/data/latest_10y.dart':
    initializeTimeZones();
   */

  // Run heavy inititalization in a separate isolate or use Future.delayed
  Future.delayed(Duration.zero, () async {
    // Android Initialization
    AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
       // Use your app icon

    // iOS initialization (if needed)
    DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    //Properly assign the initialization settingd
    InitializationSettings initalizationSettings =
    InitializationSettings(
        android: androidSettings,
        iOS: iosSettings
    );

    bool? initialized = await notificationPlugin.initialize(
        initalizationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response){
          print('Notification tapped!');
      }
    );

    log("Notifications: $initialized");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeScreen(),
    );
  }
}

