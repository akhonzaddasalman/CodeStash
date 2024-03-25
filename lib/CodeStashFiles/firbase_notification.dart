Instructions
/*
To implement firebase notification service in flutter project you need the following setup and procedure follow bellow


1. Import Dependencies:
Import necessary Dart and Flutter packages such as firebase_core,firebase_messaging,flutter_local_notifications,http and your custom model and utility classes.

2. Create Class:
Define a class named FirebaseNotificationsService.

3. Declare Variables:
Declare class variables for Firebase messaging, and local notifications plugin.
Initialize FirebaseMessaging:

3. Create an instance of FirebaseMessaging.
Initialize an instance of FlutterLocalNotificationsPlugin.

4.Request Notification Permission:
Implement a method requestNotificationPermission to request notification permissions from the user using _firebaseMessaging.requestPermission().
Initialize Notification Listeners:

Implement initNotificationListeners method to set up notification listeners for both foreground and background messages.

5. Initialize Notifications:
Implement initializeNotifications method to set up initialization settings for local notifications.

6.Firebase Initialization:
Implement firebaseInit method which is currently commented out. It seems to handle different types of notifications based on their 'type' attribute.

7.Decide Notification Type:
Implement decideNotification method that checks the 'type' attribute of the notification message and decides whether it's a message or chat notification.

8.Initialize OnTap Notifications:
Implement initOnTapNotifications method to initialize notifications on tap. It also sets foreground notification presentation options.

9.Send Notification:
Implement sendNotification method that sends a notification to a specific device using the FCM (Firebase Cloud Messaging) API.

10.Handle Background Notification:
Implement handleBackgroundNotification method that handles background notifications.

11.Show Notification:
Implement showNotification method that displays a local notification using FlutterLocalNotificationsPlugin based on the content of the received FCM message.

12.Get Device Token:
Implement getDeviceToken method to retrieve the device token from Firebase.

13.Token Refresh Handling:
Implement isTokenRefreshed method that listens for token refresh events.

14. OnTap Function:
Implement onTapFunction method that is triggered when a notification is tapped. It checks the type of notification and navigates to a specific screen.

*/


import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:ridesrides/Models/notification_model.dart';
import 'package:ridesrides/View/Utils/next_screen.dart';

class FirebaseNotificationsService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final player = AudioPlayer();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    print("requestNotificationPermission Called");
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  //Initialize notification listeners (Background, Foreground)
  void initNotificationListeners(BuildContext context) {
    print('initNotificationListeners activated');
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
      print("This is received notification $message");
      initOnTapNotifications(context, message);
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }

  void initializeNotifications(RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  void firebaseInit(BuildContext context) {
    print("Started");
    // FirebaseMessaging.onMessage.listen((message) async {
    //   print("Received");
    //   if (message.notification == null) {
    //     print("notificaiton is null");
    //   }
    //   if (message.notification?.title == null) {
    //     print("title is null");
    //   } else {
    //     //decideNotification(message, context);
    //     if (message.data["type"] == 'ride_accepted') {
    //       //await player.play(AssetSource('sounds/message.mp3'));
    //     } else if (message.data["type"] == 'arrived') {
    //       //await player.play(AssetSource('sounds/message.mp3'));
    //     } else if (message.data["type"] == 'start') {
    //       //await player.play(AssetSource('sounds/message.mp3'));
    //     } else if (message.data["type"] == 'complete') {
    //       // await player.play(AssetSource('sounds/message.mp3'));
    //     } else if (message.data["type"] == 'cancel') {
    //       //await player.play(AssetSource('sounds/message.mp3'));
    //     } else if (message.data["type"] == 'message') {
    //       // await player.play(AssetSource('sounds/message.mp3'));
    //     } else {
    //       //await player.play(AssetSource('sounds/message.mp3'));
    //     }
    //     if (kDebugMode) {
    //       // print(message.notification!.title.toString());
    //       print(message.notification!.body.toString());
    //     }
    //   }
    // });
  }

  void decideNotification(RemoteMessage message, BuildContext context) {
    if (message.data['type'] == "message") {
      //is Order
      if (Platform.isAndroid) {
        initializeNotifications(message);
        showNotification(message);
      }
    } else {
      //is chat
      if (Platform.isIOS) {
        initializeNotifications(message);
        showNotification(message);
      }
    }
  }

  //InitializeOnTapFunctions
  Future<void> initOnTapNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        onTapFunction(context, message);
      },
      // onDidReceiveBackgroundNotificationResponse: (details) {},
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> sendNotification(NotificationModel notificationModel) async {
    var data = {
      'to': notificationModel.receiverToken,
      'priority': 'high',
      'notification': {
        'title': notificationModel.title,
        'body': notificationModel.message,
      },
      'data': {
        'type': notificationModel.type,
        'userName': notificationModel.driverName,
        'carNumber': notificationModel.carNumber,
        'vehicleModel': notificationModel.vehicleModel,
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAA7SkEack:APA91bGa3BT15dTFEr6qbZt3n29s48OC3QJCgnErB-RYqHb1ZYfwrdRjFzPqm_peQ4iZErM3Np7VQR4KSXXnfVelBjWkIuOTjstAiRtKgNXmEgbe6rRD1QFgYtiDg0Rqnrn_lFokzcTS'
    });
  }

  //Handle Background Notification
  @pragma("vm:entry-point")
  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    await Firebase.initializeApp();
    showNotification(message);
  }

  Future<void> showNotification(RemoteMessage message) async {
    print("Showing");
    if (message.notification != null) {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        "High Importance Notification",
        importance: Importance.max,
      );

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id.toString(), channel.name,
          importance: Importance.high,
          channelDescription: "Your channel Description",
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher');

      const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(0, message.notification!.title.toString(), message.notification!.body.toString(), notificationDetails);
      });
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("This is token == $token");
    return token!;
  }

  isTokenRefreshed() async {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void onTapFunction(BuildContext context, RemoteMessage remoteMessage) async {
    if (remoteMessage.data["type"].toString() != "Socket") {
      final data = remoteMessage.data;
      nextScreenRemoveUntil(context, "/home");
    }
  }
}
