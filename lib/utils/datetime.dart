import 'package:flutter/material.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

extension DateTimeUtils on DateTime {
  int between(DateTime to) => daysBetween(this, to);

  DateTime operator &(TimeOfDay? time) => DateTime(
        year,
        month,
        day,
        time?.hour ?? hour,
        time?.minute ?? minute,
        // millisecond,
        // microsecond,
      );

  DateTime withTime(TimeOfDay? time) => this & time;

  DateTime operator +(Duration duration) => add(duration);

  DateTime operator -(Duration duration) => subtract(duration);
}

