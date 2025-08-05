// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NotificationController extends GetxController {
//   PushNotification pushNotification = PushNotification();
//   LocalNotification localNotification = LocalNotification();
//   late SharedPreferences prefs;
//
//   initializeNotifications() async {
//     prefs = await SharedPreferences.getInstance();
//     await localNotification.initialize(prefs);
//     pushNotification.setForegroundListener(
//         localNotification: localNotification);
//   }
// }
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
// }
//
// class PushNotification {
//   setForegroundListener({required LocalNotification localNotification}) {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // *** Handle the message notification!
//       log("##User just got a notification!");
//       if (message.notification != null) {
//         localNotification.showPushedNotification(message);
//       }
//     });
//   }
// }
//
// class LocalNotification {
//   FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
//   NotificationDetails? currentNotificationDetail;
//   SharedPreferences? pref;
//   int _notificationCount = 0;
//   BuildContext? context;
//
//   int getNotificationCount() => _notificationCount;
//   setCount(int orderId) {
//     _notificationCount = orderId;
//     Get.find<LocalStorage>()
//         .settInt(key: StorageKeys.orderId, value: _notificationCount);
//
//     /// pref!.setInt("OrderId", _notificationCount);
//   }
//
//   int useCount() {
//     int id = _notificationCount;
//     setCount(id++);
//     return id;
//   }
//
//   initialize(SharedPreferences prefs) {
//     pref = prefs;
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSetting = DarwinInitializationSettings();
//     setImportantAndroidNotification();
//     const initializationsSettings =
//     InitializationSettings(android: androidSetting, iOS: iosSetting);
//     flutterLocalNotificationsPlugin!.initialize(initializationsSettings);
//     _notificationCount =
//         Get.find<LocalStorage>().getInt(key: StorageKeys.orderId) ?? 0;
//   }
//
//   setImportantAndroidNotification() {
//     currentNotificationDetail = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'org.practicingmuslim.app',
//         'Folder Structure',
//         number: _notificationCount,
//         playSound: true,
//         importance: Importance.max,
//         priority: Priority.max,
//       ),
//       iOS: DarwinNotificationDetails(
//         badgeNumber: _notificationCount,
//         presentBadge: true,
//         presentAlert: true,
//       ),
//     );
//   }
//
//   showTextNotification(String title, String body, String? payload) async {
//     await flutterLocalNotificationsPlugin!.show(
//         useCount(), title, body, currentNotificationDetail,
//         payload: payload ?? "");
//   }
//
//   showPushedNotification(RemoteMessage pushedNotification) async {
//     if (pushedNotification.notification?.title != null) {
//       await showTextNotification(pushedNotification.notification!.title!,
//           pushedNotification.notification!.body!, null);
//     } else {
//       //* Manage Data *//
//     }
//   }
// }
