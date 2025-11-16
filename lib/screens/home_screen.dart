import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/main.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showBasicNotification() async{
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

  // NEW : Custom Notification with Images
  void showCustomNotification() async {
    try {
      // For Android - Using BigPictureStyle for custom layout
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            "custom-notification-channel",
            "Custom Notifications",
            channelDescription: 'Channel for custom styled notifications',
            priority: Priority.high,
            importance: Importance.high,
            playSound: true,
            enableVibration: true,
            visibility: NotificationVisibility.public,
            styleInformation: BigPictureStyleInformation(
              // Large Image on the right side
              DrawableResourceAndroidBitmap('right_image'), // Your custom PNG
              largeIcon: DrawableResourceAndroidBitmap('custom_logo'),
              // Small icon on left
              contentTitle: 'Custom Notification Title', // Custom title
              summaryText: 'This is a detailed description with custom styling!',
              // Detailed description
              htmlFormatContentTitle: true,
            ),
          );

      // For iOS
      const DarwinNotificationDetails iosDetails =
          DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            attachments: <DarwinNotificationAttachment>[
              // You can add image attachments for iOS too
            ],
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await notificationPlugin.show(
          1, // Different ID
          'Premium Update Available!',
          'Upgrade now to unlock exclusive features and enhanced performance!',
          // Body
          notificationDetails,
          payload: 'custom_notification' // Optional payload
      );

      print("Custom notification shown successfully!");
    } catch(e){
      print('Error showing custom notification: $e');
    }
  }

  // NEW: Notification with Indox Style (Multiple lines)
  void showIndoxStyleNotification() async {
    try {
      final List<String> lines = [
        'New message from John',
        'Meeting reminder at 3 PM',
        'Your order has been shipped',
        'Special offer just for u!'
      ];

      final AndroidNotificationDetails androidDetails =
       AndroidNotificationDetails(
       "indox-notification-channel",
       "Indox Notifications",
       channelDescription: 'Channel for inbox style notifications',
       priority: Priority.high,
       playSound: true,
       styleInformation: InboxStyleInformation(
           lines,
           contentTitle: 'You have ${lines.length} new updates',
           summaryText: 'Multiple updates waiting',
           htmlFormatLines: true,
        ),
       );

      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentSound: true,
          presentBadge: true,
          presentAlert: true,
        ),
      );

      await notificationPlugin.show(
          2,
          'Multiple Updates',
          'You have several new notifications',
          notificationDetails
      );
      print("Indox style notification shown successfully!");
    } catch(e){
      print('Error showing indox notification: $e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        // title: Text('Local Notifications Demo'),
        title: Text('Advanced Notifications Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: showNotification,
      //     child: Icon(Icons.notification_add),
      // ),  // Floating Action Button
    body: SafeArea(
     //   child: Center(
     //     child: Text(
     //       'PRESS THE BUTTON TO SHOW NOTIFICATION',
     //       style: TextStyle(fontSize: 18),
     //     ),
     //  ),
     // ), // Safe Area
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Basic Notification Button
          ElevatedButton.icon(
              onPressed: showBasicNotification,
              icon: Icon(Icons.notifications),
              label: Text('Basic Notification'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
          ),
          SizedBox(height: 20),

          //Custom Notification Button
          ElevatedButton.icon(
              onPressed: showCustomNotification,
              icon: Icon(Icons.photo_library,color: Colors.white),
              label: Text('Custom Image Notification', style: TextStyle(
                color: Colors.white
              )),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
          ),

          // Inbox Style Notification Button
          ElevatedButton.icon(
              onPressed: showIndoxStyleNotification,
              icon: Icon(Icons.inbox, color: Colors.white),
              label: Text('Inbox Style Notification', style: TextStyle(
                color: Colors.white
              )),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              ),
          q),

          SizedBox(height: 40),
          Text(
            'Choose Notification Style',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
          ),
        ],
      ),
     ),
    );// Scaffold
  }
}