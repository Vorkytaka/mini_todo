import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin;

  const NotificationService({
    required this.plugin,
  });

  Future<List<int>> getActiveNotifications() {
    return plugin.pendingNotificationRequests().then((value) => value.map((e) => e.id).toList(growable: false));
  }

  Future addNotification(Todo todo) async {
    if (todo.date == null || todo.time == null) return;

    final time = todo.date!.add(Duration(hours: todo.time!.hour, minutes: todo.time!.minute));

    final now = DateTime.now();
    if (time.isBefore(now)) return;

    return plugin.zonedSchedule(
      todo.id,
      todo.title,
      null,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'miniTodo.reminders',
          'Reminders',
          channelDescription: 'Remind you about your tasks',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      androidAllowWhileIdle: true,
    );
  }

  Future cancelNotification(Todo todo) async {
    return plugin.cancel(todo.id);
  }
}
