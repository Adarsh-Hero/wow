import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final androidSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOSSetting = const IOSInitializationSettings();
    final overallSetting =
        InitializationSettings(android: androidSetting, iOS: iOSSetting);
    await _notifications.initialize(
      overallSetting,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification(
          {int id = 0, String title, String body, String payload}) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
