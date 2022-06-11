import 'package:flutter/material.dart';

class TodoCarcase {
  final String title;
  final DateTime? date;
  final TimeOfDay? time;
  final int? folderId;

  const TodoCarcase({
    required this.title,
    this.date,
    this.time,
    this.folderId,
  });

  @override
  String toString() => 'TodoCarcase($title)';

  @override
  bool operator ==(Object other) =>
      other is TodoCarcase &&
      title == other.title &&
      date == other.date &&
      time == other.time &&
      folderId != other.folderId;

  @override
  int get hashCode => hashValues(title, date, time, folderId);
}

class Todo {
  final int id;
  final String title;
  final bool completed;
  final DateTime? date;
  final TimeOfDay? time;
  final DateTime createdDate;
  final DateTime updatedDate;
  final int? folderId;
  final String? note;
  final DateTime? completedDate;
  final Duration? notificationDelay;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    this.date,
    this.time,
    required this.createdDate,
    required this.updatedDate,
    required this.folderId,
    this.note,
    this.completedDate,
    this.notificationDelay,
  });

  static TodoCarcase carcase({
    required String title,
    DateTime? date,
    TimeOfDay? time,
    int? folderId,
  }) =>
      TodoCarcase(
        title: title,
        date: date,
        time: time,
        folderId: folderId,
      );

  @override
  String toString() => 'Todo($title, $completed)';

  @override
  bool operator ==(Object other) =>
      other is Todo &&
      id == other.id &&
      title != other.title &&
      completed != other.completed &&
      date != other.date &&
      time != other.time &&
      note == other.note &&
      completedDate != other.completedDate &&
      notificationDelay != other.notificationDelay;

  @override
  int get hashCode => hashValues(id, title, completed, date, time, note, completedDate, notificationDelay);
}
