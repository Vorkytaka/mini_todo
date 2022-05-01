// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoTableData extends DataClass implements Insertable<TodoTableData> {
  final int id;
  final String title;
  final bool completed;
  final DateTime? date;
  final TimeOfDay? time;
  final DateTime createdDate;

  TodoTableData(
      {required this.id,
      required this.title,
      required this.completed,
      this.date,
      this.time,
      required this.createdDate});

  factory TodoTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoTableData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      completed: const BoolType().mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      date: $TodoTableTable.$converter0
          .mapToDart(const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}date'])),
      time: $TodoTableTable.$converter1
          .mapToDart(const IntType().mapFromDatabaseResponse(data['${effectivePrefix}time'])),
      createdDate: const DateTimeType().mapFromDatabaseResponse(data['${effectivePrefix}created_date'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || date != null) {
      final converter = $TodoTableTable.$converter0;
      map['date'] = Variable<DateTime?>(converter.mapToSql(date));
    }
    if (!nullToAbsent || time != null) {
      final converter = $TodoTableTable.$converter1;
      map['time'] = Variable<int?>(converter.mapToSql(time));
    }
    map['created_date'] = Variable<DateTime>(createdDate);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      id: Value(id),
      title: Value(title),
      completed: Value(completed),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      createdDate: Value(createdDate),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      date: serializer.fromJson<DateTime?>(json['date']),
      time: serializer.fromJson<TimeOfDay?>(json['time']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
      'date': serializer.toJson<DateTime?>(date),
      'time': serializer.toJson<TimeOfDay?>(time),
      'createdDate': serializer.toJson<DateTime>(createdDate),
    };
  }

  TodoTableData copyWith(
          {int? id, String? title, bool? completed, DateTime? date, TimeOfDay? time, DateTime? createdDate}) =>
      TodoTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        date: date ?? this.date,
        time: time ?? this.time,
        createdDate: createdDate ?? this.createdDate,
      );

  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, completed, date, time, createdDate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.date == this.date &&
          other.time == this.time &&
          other.createdDate == this.createdDate);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  final Value<DateTime?> date;
  final Value<TimeOfDay?> time;
  final Value<DateTime> createdDate;

  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.createdDate = const Value.absent(),
  });

  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.createdDate = const Value.absent(),
  }) : title = Value(title);

  static Insertable<TodoTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? completed,
    Expression<DateTime?>? date,
    Expression<TimeOfDay?>? time,
    Expression<DateTime>? createdDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (createdDate != null) 'created_date': createdDate,
    });
  }

  TodoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? completed,
      Value<DateTime?>? date,
      Value<TimeOfDay?>? time,
      Value<DateTime>? createdDate}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      time: time ?? this.time,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (date.present) {
      final converter = $TodoTableTable.$converter0;
      map['date'] = Variable<DateTime?>(converter.mapToSql(date.value));
    }
    if (time.present) {
      final converter = $TodoTableTable.$converter1;
      map['time'] = Variable<int?>(converter.mapToSql(time.value));
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $TodoTableTable(this.attachedDatabase, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>('id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false, defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>('title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>('completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, DateTime?> date =
      GeneratedColumn<DateTime?>('date', aliasedName, true, type: const IntType(), requiredDuringInsert: false)
          .withConverter<DateTime>($TodoTableTable.$converter0);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, int?> time =
      GeneratedColumn<int?>('time', aliasedName, true, type: const IntType(), requiredDuringInsert: false)
          .withConverter<TimeOfDay>($TodoTableTable.$converter1);
  final VerificationMeta _createdDateMeta = const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime?> createdDate = GeneratedColumn<DateTime?>('created_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false, defaultValue: currentDateAndTime);

  @override
  List<GeneratedColumn> get $columns => [id, title, completed, date, time, createdDate];

  @override
  String get aliasedName => _alias ?? 'todo_table';

  @override
  String get actualTableName => 'todo_table';

  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta, completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    context.handle(_dateMeta, const VerificationResult.success());
    context.handle(_timeMeta, const VerificationResult.success());
    if (data.containsKey('created_date')) {
      context.handle(_createdDateMeta, createdDate.isAcceptableOrUnknown(data['created_date']!, _createdDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoTableData.fromData(data, prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, DateTime> $converter0 = const DateConverter();
  static TypeConverter<TimeOfDay, int> $converter1 = const TimeConverter();
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTableTable todoTable = $TodoTableTable(this);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoTable];
}
