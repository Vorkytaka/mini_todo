import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay, DateUtils;

class TodoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 255)();

  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  DateTimeColumn get date => dateTime().map(const DateConverter()).nullable()();

  IntColumn get time => integer().map(const TimeConverter()).nullable()();

  DateTimeColumn get createdDate => dateTime().withDefault(currentDateAndTime)();
}

class DateConverter implements TypeConverter<DateTime, DateTime> {
  const DateConverter();

  @override
  DateTime? mapToDart(DateTime? fromDb) {
    if (fromDb == null) return null;
    return DateUtils.dateOnly(fromDb);
  }

  @override
  DateTime? mapToSql(DateTime? value) {
    if (value == null) return null;
    return DateUtils.dateOnly(value);
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
