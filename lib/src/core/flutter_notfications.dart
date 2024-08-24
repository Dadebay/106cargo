// import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationManager {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> setupNotifications() async {
//     firebaseMessaging.getInitialMessage().then((RemoteMessage message) {
//        _showNotification(message);
//     } );

//     // Handle incoming message while app is in the foreground

//     // Other callback methods...

//     final initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final initializationSettingsIOS = IOSFlutterLocalNotificationsPlugin();
//     final initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> _showNotification(Map<String, dynamic> message) async {
//     final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'Your Channel Name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     final iOSPlatformChannelSpecifics = IOS ();
//     final platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       message['notification']['title'], // Notification title
//       message['notification']['body'], // Notification body
//       platformChannelSpecifics,
//     );
//   }
// }
