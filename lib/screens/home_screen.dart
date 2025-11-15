import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/main.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showNotification() async{
    AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails(
            "demo-notification-aniket",
            "Notifications Aniket",
            channelDescription: 'It\'s Demo Description To Test Notification',
            priority: Priority.high, // Changed from max to high
            importance: Importance.high, // Changed from max to High
            playSound: true, // Add sound
            enableVibration: true, // Add Vibration
            visibility: NotificationVisibility.public, // Make it visible everywhere
            // ticker: 'ticker',
        );

    DarwinNotificationDetails iosDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notiDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails
    );
    
    /*  This will be Helpfull If U want to Schedule the Pop up Time of notification after User click on Button
    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    BUT PROBLEM IS ITS DEPRECATED:
    Instead of Show we use Schedule to pop Up notification at our decided time
    await notificationPlugin.schedule(0, "Sample Notification",
        "This is Notification", scheduleDate ,notiDetails);

     To Use A think Which is Relevant in Todays Market Instead of Old Schedule
     It's Work on Time Zone Date Time(TZDateTime) Where u find out 'TZDateTime'
     So, It's Necessary for u To Download(PUBSPEC.YAML) a package called timezone 0.9.0

     let's Suppose We imported package 'import 'package:timezone/timezone.dart' as tz;'
      Just we have to Change Only line
     await notificationPlugin.zonedSchedule(0, "Sample Notification",
        "This is Notification", tz.TZDateTime.from(
        scheduleDate, tz.local
        ),
        notiDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime
        androidAllowWhileIdle: true
        );
     */

    try {
      await notificationPlugin.show(
        0, //Notification ID
        "Sample Notification Title",
        "This is Notification Body",
        notiDetails,
      );
      print("Notification shown successfully");
    } catch (e){
      print('Error showing notification: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notifications Demo'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: showNotification,
          child: Icon(Icons.notification_add),
      ),  // Floating Action Button
    body: SafeArea(
       child: Center(
         child: Text(
           'PRESS THE BUTTON TO SHOW NOTIFICATION',
           style: TextStyle(fontSize: 18),
         ),
      ),
     ), // Safe Area
    ); // Scaffold
  }
}