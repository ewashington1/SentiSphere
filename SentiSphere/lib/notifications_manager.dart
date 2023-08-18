import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationsManager() {
    final initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Handle notification tap if required
      },
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyReminder() async {
    var time = Time(21, 0, 0); // 9:00 PM

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      // 'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Time to write a gratitude note!',
      'Write down something you are thankful for today.',
      time,
      platformChannelSpecifics,
    );
  }

  Future<void> cancelReminder() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
