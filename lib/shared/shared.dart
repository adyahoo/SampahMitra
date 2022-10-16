import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampah_mitra/main.dart';
import 'package:supercharged/supercharged.dart';

part 'theme.dart';

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['title'],
    message.data['body'],
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'logo2',
      ),
    ),
  );
  // if (notification != null && android != null) {
  // }
}