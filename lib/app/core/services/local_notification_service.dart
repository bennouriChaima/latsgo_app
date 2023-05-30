import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:urban_app/app/core/styles/colors.dart';
import 'package:flutter/material.dart';

class LocalNotificationsService {
  Future<void> initialize() async {
    AwesomeNotifications().initialize(
        null, // icon for your app notification
        [
          NotificationChannel(
            channelKey: 'aratok',
            channelName: 'aratok',
            channelDescription: "aratok notification",
            defaultColor: MainColors.primaryColor,
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            enableVibration: true,
            importance: NotificationImportance.Max,
          )
        ]);
  }

  void showNotification(var title, var body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1, channelKey: 'aratok', title: title, body: body, wakeUpScreen: true, color: MainColors.primaryColor));
  }
}
