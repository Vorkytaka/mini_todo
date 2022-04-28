import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  final bool completed;
  final DateTime? date;
  final TimeOfDay? time;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    this.date,
    this.time,
  });

  @override
  String toString() => 'Todo($id, $title)';

  @override
  bool operator ==(Object other) => other is Todo && id == other.id;

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
