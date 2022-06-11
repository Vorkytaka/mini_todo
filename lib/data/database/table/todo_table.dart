import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;

import '../../../entity/todo.dart';
import '../database.dart';

class TodoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(max: 255)();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  IntColumn get date => integer().map(const DateConverter()).nullable()();

  IntColumn get time => integer().map(const TimeConverter()).nullable()();

  DateTimeColumn get createdDate => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedDate => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get completedDate => dateTime().nullable()();

  IntColumn get folderId => integer().nullable()();

  TextColumn get note => text().nullable()();

  IntColumn get notificationDelay => integer().map(const DurationConverter()).nullable()();
}

class DateConverter implements TypeConverter<DateTime, int> {
  const DateConverter();

  @override
  DateTime? mapToDart(int? fromDb) {
    if (fromDb == null) return null;
    final utc = DateTime.fromMillisecondsSinceEpoch(fromDb * 1000, isUtc: true);
    return DateTime(utc.year, utc.month, utc.day);
  }

  @override
  int? mapToSql(DateTime? value) {
    if (value == null) return null;
    final utc = DateTime.utc(value.year, value.month, value.day);
    return utc.millisecondsSinceEpoch ~/ 1000;
  }
}

class TimeConverter implements TypeConverter<TimeOfDay, int> {
  const TimeConverter();

  @override
  TimeOfDay? mapToDart(int? fromDb) {
    if (fromDb == null) return null;
    return TimeOfDay(hour: fromDb ~/ 60, minute: fromDb % 60);
  }

  @override
  int? mapToSql(TimeOfDay? value) {
    if (value == null) return null;
    return value.hour * 60 + value.minute;
  }
}

class DurationConverter implements TypeConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration? mapToDart(int? fromDb) {
    if (fromDb == null) return null;
    return Duration(minutes: fromDb);
  }

  @override
  int? mapToSql(Duration? value) {
    if (value == null) return null;
    return value.inMinutes;
  }
}

extension TodoTableUtils on TodoTableData {
  Todo get toTodo => Todo(
        id: id,
        title: title,
        completed: completed,
        date: date,
        time: time,
        createdDate: createdDate,
        updatedDate: updatedDate,
        folderId: folderId,
        note: note,
        completedDate: completedDate,
        notificationDelay: notificationDelay,
      );
}
