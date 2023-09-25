import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationUtility {
  static int id = 0;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationUtility() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeTimeZone();
  }

  // Initialize time zone for notifications
  Future<void> _initializeTimeZone() async {
    tzdata.initializeTimeZones();
    tz.timeZoneDatabase;
    const String timeZoneName = 'Asia/Kolkata';
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  // Initialize notification settings
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Create notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'Farm Product',
      'Easy way to reach farm product',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Show a custom notification with a sound
  Future<void> showNotificationCustomSound() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Farm Product',
      'Easy way to reach farm product',
      channelDescription: 'Easy way to reach farm product',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'logo',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id++,
      'Farm Product',
      'Easy way to reach farm product',
      notificationDetails,
    );
  }

  // Schedule a notification to appear after 5 seconds
  Future<void> scheduleNotificationAfter5Seconds() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id++,
      'Farm ProductF',
      'Easy way to reach farm product',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'Farm Product',
        'Easy way to reach farm products',
        channelDescription: 'Easy way to reach farm product',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: 'logo',
      )),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
