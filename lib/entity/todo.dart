import 'package:flutter/material.dart';

class TodoCarcase {
  final String title;
  final DateTime? date;
  final TimeOfDay? time;

  const TodoCarcase({
    required this.title,
    this.date,
    this.time,
  });

  @override
  String toString() => 'TodoCarcase($title)';

  @override
  bool operator ==(Object other) =>
      other is TodoCarcase && title == other.title && date == other.date && time == other.time;

  @override
  int get hashCode => hashValues(title, date, time);
}

class Todo {
  final int id;
  final String title;
  final bool completed;
  final DateTime? date;
  final TimeOfDay? time;
  final DateTime createdDate;
  final DateTime updatedDate;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    this.date,
    this.time,
    required this.createdDate,
    required this.updatedDate,
  });

  static TodoCarcase carcase({
    required String title,
    DateTime? date,
    TimeOfDay? time,
  }) =>
      TodoCarcase(
        title: title,
        date: date,
        time: time,
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
      time != other.time;

  @override
  int get hashCode => id.hashCode;

  Todo copyWith({
    String? title,
    bool? completed,
    DateTime? date,
    TimeOfDay? time,
  }) =>
      Todo(
        id: id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        date: date ?? this.date,
        time: time ?? this.time,
        createdDate: createdDate,
        updatedDate: updatedDate,
      );

  DateTime? get datetime {
    if (date == null) {
      return null;
    }

    if (time == null) {
      return date;
    }

    return date!.add(Duration(hours: time!.hour, minutes: time!.minute));
  }
}
