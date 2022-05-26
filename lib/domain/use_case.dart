import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mini_todo/data/notification/notification_repository.dart';
import 'package:mini_todo/data/todo_repository.dart';
import 'package:mini_todo/entity/todo.dart';

typedef UseCase<O, P> = O Function(BuildContext context, P params);

Future<void> createTodo(BuildContext context, TodoCarcase carcase) async {
  final todoRepository = context.read<TodoRepository>();
  final todo = await todoRepository.create(carcase);

  if (todo.date != null && todo.time != null) {
    await _addNotification(context, todo);
  }
}

Future<void> updateTodoDate(BuildContext context, int id, DateTime date) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.setDate(id, date);
  await _addNotificationById(context, id);
}

Future<void> deleteTodoDate(BuildContext context, int id) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.removeDate(id);
  await _cancelNotification(context, id);
}

Future<void> updateTodoTime(BuildContext context, int id, TimeOfDay time) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.setTime(id, time);
  await _addNotificationById(context, id);
}

Future<void> deleteTodoTime(BuildContext context, int id) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.removeTime(id);
  await _cancelNotification(context, id);
}

Future<void> completeTodo(BuildContext context, int id, bool completed) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.setCompleted(id, completed);
  if (completed) {
    await _cancelNotification(context, id);
  } else {
    await _addNotificationById(context, id);
  }
}

Future<void> deleteTodo(BuildContext context, int id) async {
  final todoRepository = context.read<TodoRepository>();
  await todoRepository.delete(id);
  _cancelNotification(context, id);
}

/// -----------------------
/// ---- notifications ----
/// -----------------------

Future<void> _addNotification(BuildContext context, Todo todo) async {
  if (todo.date == null || todo.time == null) return;

  final datetime = todo.date!.add(Duration(hours: todo.time!.hour, minutes: todo.time!.minute));

  final now = DateTime.now();
  if (datetime.isBefore(now)) return;

  final notificationRepository = context.read<NotificationRepository>();
  return notificationRepository.scheduleNotification(
    todo.id,
    todo.title,
    datetime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'miniTodo.reminders',
        'Reminders',
        channelDescription: 'In this channel we remind you about your tasks',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
  );
}

Future<void> _addNotificationById(BuildContext context, int todoId) async {
  final todoRepository = context.read<TodoRepository>();
  final todo = await todoRepository.readById(todoId);

  if (todo != null) {
    _addNotification(context, todo);
  }
}

Future<void> _cancelNotification(BuildContext context, int todoId) async {
  final notificationRepository = context.read<NotificationRepository>();
  await notificationRepository.cancelScheduledNotification(todoId);
}
