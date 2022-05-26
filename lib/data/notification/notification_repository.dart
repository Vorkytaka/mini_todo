import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationRepository {
  Future<void> scheduleNotification(
    int id,
    String title,
    DateTime datetime,
    NotificationDetails details,
  );

  Future<void> cancelScheduledNotification(
    int id,
  );
}

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin plugin;

  NotificationRepositoryImpl({
    required this.plugin,
  });

  @override
  Future<void> scheduleNotification(int id, String title, DateTime datetime, NotificationDetails details) {
    return plugin.zonedSchedule(
      id,
      title,
      null,
      tz.TZDateTime.from(datetime, tz.local),
      details,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  @override
  Future<void> cancelScheduledNotification(int id) {
    return plugin.cancel(id);
  }
}
