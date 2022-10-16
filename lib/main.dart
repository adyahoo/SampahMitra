import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sampah_mitra/data/cubit/cubit.dart';
import 'package:sampah_mitra/data/cubit/transaksi_cubit.dart';
import 'package:sampah_mitra/data/services/services.dart';
import 'package:sampah_mitra/shared/shared.dart';
import 'package:sampah_mitra/ui/pages/pages.dart';
import 'package:sampah_mitra/ui/widgets/widgets.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
      'high_importance_channel_13', // id
      'High Importance Notifications 13', // title
      description:
          'This channel is used for important notifications 13.', // description
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notif'));

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void registerNotification() async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  final firebaseMsg = FirebaseMessaging.instance;

  NotificationSettings settings = await firebaseMsg.requestPermission(
      alert: true, badge: true, provisional: false, sound: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? userToken = await getUserToken();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  registerNotification();

  runApp(MyApp(
    token: userToken,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => TransaksiCubit()),
        BlocProvider(
          create: (context) => NasabahCubit(),
        )
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: LoadingOverlay(),
        child: OverlaySupport(
          child: GetMaterialApp(
            title: 'Mitra GunaBangsa',
            theme: ThemeData(primarySwatch: Colors.lightGreen),
            home: token == null ? LoginPage() : MainPage(),
          ),
        ),
      ),
    );
  }
}
