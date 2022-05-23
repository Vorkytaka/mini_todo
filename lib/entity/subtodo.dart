import 'package:flutter/cupertino.dart';

class Subtodo {
  final int id;
  final String title;
  final bool completed;

  const Subtodo({
    required this.id,
    required this.title,
    required this.completed,
  });

  @override
  bool operator ==(Object other) =>
      other is Subtodo && id == other.id && title == other.title && completed == other.completed;

  @override
  int get hashCode => hashValues(id, title, completed);
}
