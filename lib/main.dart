import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:urban_app/app/core/constants/storage_keys_constants.dart';
import 'package:urban_app/app/core/services/local_notification_service.dart';
import 'package:urban_app/app/core/services/local_storage_service.dart';
import 'package:urban_app/app/core/styles/theme_styles.dart';
import 'package:urban_app/app/core/utils/translations/translation.dart';
import 'package:urban_app/app/core/utils/translations/translations_assets_reader.dart';
import 'package:urban_app/app/models/push_notification_model.dart';
import 'package:urban_app/app/modules/user_controller.dart';

import 'app/routes/app_pages.dart';

late final FirebaseMessaging _messaging;
PushNotificationModel? _notificationInfo;

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('message: ${message.messageId}');
}

void requestAndRegisterNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) async {
    print('firebase token: ${token}');
    if (await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string) == null) {
      LocalStorageService.saveData(key: StorageKeysConstants.fcmToken, value: token, type: DataTypes.string);
    }
  });

  // 2. Instantiate Firebase Messaging
  _messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    String? token = await _messaging.getToken();
    print("The token is " + token!);
    // For handling the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.body);
      // Parse the message received
      PushNotificationModel notification = PushNotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      LocalNotificationsService().showNotification(notification.title, notification.body);
    });
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationsAssetsReader.initialize();
  await Firebase.initializeApp();
  await LocalNotificationsService().initialize();
  Get.put(UserController(), permanent: true);
  requestAndRegisterNotification();
  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          transitionDuration: const Duration(milliseconds: 300),
          defaultTransition: Transition.circularReveal,
          debugShowCheckedModeBanner: false,
          title: "UrbanApp",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          translations: Translation(),
          locale: Locale('fr'),
          fallbackLocale: Locale('en'),
          themeMode: ThemeMode.light,
          theme: ThemeStyles.lightTheme,
          darkTheme: ThemeStyles.darkTheme,
        );
      },
    ),
  );
}
