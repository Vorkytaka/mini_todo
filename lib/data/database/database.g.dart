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
  final DateTime updatedDate;
  final DateTime? completedDate;
  final int? folderId;
  final String? note;
  final Duration? notificationOffset;
  TodoTableData(
      {required this.id,
      required this.title,
      required this.completed,
      this.date,
      this.time,
      required this.createdDate,
      required this.updatedDate,
      this.completedDate,
      this.folderId,
      this.note,
      this.notificationOffset});
  factory TodoTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      date: $TodoTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])),
      time: $TodoTableTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])),
      createdDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date'])!,
      updatedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date'])!,
      completedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_date']),
      folderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}folder_id']),
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note']),
      notificationOffset: $TodoTableTable.$converter2.mapToDart(const IntType()
          .mapFromDatabaseResponse(
              data['${effectivePrefix}notification_offset'])),
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
      map['date'] = Variable<int?>(converter.mapToSql(date));
    }
    if (!nullToAbsent || time != null) {
      final converter = $TodoTableTable.$converter1;
      map['time'] = Variable<int?>(converter.mapToSql(time));
    }
    map['created_date'] = Variable<DateTime>(createdDate);
    map['updated_date'] = Variable<DateTime>(updatedDate);
    if (!nullToAbsent || completedDate != null) {
      map['completed_date'] = Variable<DateTime?>(completedDate);
    }
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<int?>(folderId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String?>(note);
    }
    if (!nullToAbsent || notificationOffset != null) {
      final converter = $TodoTableTable.$converter2;
      map['notification_offset'] =
          Variable<int?>(converter.mapToSql(notificationOffset));
    }
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
      updatedDate: Value(updatedDate),
      completedDate: completedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDate),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      notificationOffset: notificationOffset == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationOffset),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      date: serializer.fromJson<DateTime?>(json['date']),
      time: serializer.fromJson<TimeOfDay?>(json['time']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      completedDate: serializer.fromJson<DateTime?>(json['completedDate']),
      folderId: serializer.fromJson<int?>(json['folderId']),
      note: serializer.fromJson<String?>(json['note']),
      notificationOffset:
          serializer.fromJson<Duration?>(json['notificationOffset']),
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
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'completedDate': serializer.toJson<DateTime?>(completedDate),
      'folderId': serializer.toJson<int?>(folderId),
      'note': serializer.toJson<String?>(note),
      'notificationOffset': serializer.toJson<Duration?>(notificationOffset),
    };
  }

  TodoTableData copyWith(
          {int? id,
          String? title,
          bool? completed,
          DateTime? date,
          TimeOfDay? time,
          DateTime? createdDate,
          DateTime? updatedDate,
          DateTime? completedDate,
          int? folderId,
          String? note,
          Duration? notificationOffset}) =>
      TodoTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        date: date ?? this.date,
        time: time ?? this.time,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        completedDate: completedDate ?? this.completedDate,
        folderId: folderId ?? this.folderId,
        note: note ?? this.note,
        notificationOffset: notificationOffset ?? this.notificationOffset,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('folderId: $folderId, ')
          ..write('note: $note, ')
          ..write('notificationOffset: $notificationOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, completed, date, time, createdDate,
      updatedDate, completedDate, folderId, note, notificationOffset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.date == this.date &&
          other.time == this.time &&
          other.createdDate == this.createdDate &&
          other.updatedDate == this.updatedDate &&
          other.completedDate == this.completedDate &&
          other.folderId == this.folderId &&
          other.note == this.note &&
          other.notificationOffset == this.notificationOffset);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  final Value<DateTime?> date;
  final Value<TimeOfDay?> time;
  final Value<DateTime> createdDate;
  final Value<DateTime> updatedDate;
  final Value<DateTime?> completedDate;
  final Value<int?> folderId;
  final Value<String?> note;
  final Value<Duration?> notificationOffset;
  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.folderId = const Value.absent(),
    this.note = const Value.absent(),
    this.notificationOffset = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.folderId = const Value.absent(),
    this.note = const Value.absent(),
    this.notificationOffset = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TodoTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? completed,
    Expression<DateTime?>? date,
    Expression<TimeOfDay?>? time,
    Expression<DateTime>? createdDate,
    Expression<DateTime>? updatedDate,
    Expression<DateTime?>? completedDate,
    Expression<int?>? folderId,
    Expression<String?>? note,
    Expression<Duration?>? notificationOffset,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (completedDate != null) 'completed_date': completedDate,
      if (folderId != null) 'folder_id': folderId,
      if (note != null) 'note': note,
      if (notificationOffset != null) 'notification_offset': notificationOffset,
    });
  }

  TodoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? completed,
      Value<DateTime?>? date,
      Value<TimeOfDay?>? time,
      Value<DateTime>? createdDate,
      Value<DateTime>? updatedDate,
      Value<DateTime?>? completedDate,
      Value<int?>? folderId,
      Value<String?>? note,
      Value<Duration?>? notificationOffset}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      date: date ?? this.date,
      time: time ?? this.time,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      completedDate: completedDate ?? this.completedDate,
      folderId: folderId ?? this.folderId,
      note: note ?? this.note,
      notificationOffset: notificationOffset ?? this.notificationOffset,
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
      map['date'] = Variable<int?>(converter.mapToSql(date.value));
    }
    if (time.present) {
      final converter = $TodoTableTable.$converter1;
      map['time'] = Variable<int?>(converter.mapToSql(time.value));
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (completedDate.present) {
      map['completed_date'] = Variable<DateTime?>(completedDate.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<int?>(folderId.value);
    }
    if (note.present) {
      map['note'] = Variable<String?>(note.value);
    }
    if (notificationOffset.present) {
      final converter = $TodoTableTable.$converter2;
      map['notification_offset'] =
          Variable<int?>(converter.mapToSql(notificationOffset.value));
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
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('folderId: $folderId, ')
          ..write('note: $note, ')
          ..write('notificationOffset: $notificationOffset')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable
    with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int?> date =
      GeneratedColumn<int?>('date', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<DateTime>($TodoTableTable.$converter0);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay, int?> time =
      GeneratedColumn<int?>('time', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<TimeOfDay>($TodoTableTable.$converter1);
  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime?> createdDate =
      GeneratedColumn<DateTime?>('created_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  @override
  late final GeneratedColumn<DateTime?> updatedDate =
      GeneratedColumn<DateTime?>('updated_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _completedDateMeta =
      const VerificationMeta('completedDate');
  @override
  late final GeneratedColumn<DateTime?> completedDate =
      GeneratedColumn<DateTime?>('completed_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _folderIdMeta = const VerificationMeta('folderId');
  @override
  late final GeneratedColumn<int?> folderId = GeneratedColumn<int?>(
      'folder_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _notificationOffsetMeta =
      const VerificationMeta('notificationOffset');
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int?>
      notificationOffset = GeneratedColumn<int?>(
              'notification_offset', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<Duration>($TodoTableTable.$converter2);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        completed,
        date,
        time,
        createdDate,
        updatedDate,
        completedDate,
        folderId,
        note,
        notificationOffset
      ];
  @override
  String get aliasedName => _alias ?? 'todo_table';
  @override
  String get actualTableName => 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    context.handle(_dateMeta, const VerificationResult.success());
    context.handle(_timeMeta, const VerificationResult.success());
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date']!, _updatedDateMeta));
    }
    if (data.containsKey('completed_date')) {
      context.handle(
          _completedDateMeta,
          completedDate.isAcceptableOrUnknown(
              data['completed_date']!, _completedDateMeta));
    }
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    context.handle(_notificationOffsetMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, int> $converter0 = const DateConverter();
  static TypeConverter<TimeOfDay, int> $converter1 = const TimeConverter();
  static TypeConverter<Duration, int> $converter2 = const DurationConverter();
}

class FolderTableData extends DataClass implements Insertable<FolderTableData> {
  final int id;
  final String title;
  final Color? color;
  final DateTime createdDate;
  final DateTime updatedDate;
  FolderTableData(
      {required this.id,
      required this.title,
      this.color,
      required this.createdDate,
      required this.updatedDate});
  factory FolderTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FolderTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      color: $FolderTableTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])),
      createdDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date'])!,
      updatedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || color != null) {
      final converter = $FolderTableTable.$converter0;
      map['color'] = Variable<int?>(converter.mapToSql(color));
    }
    map['created_date'] = Variable<DateTime>(createdDate);
    map['updated_date'] = Variable<DateTime>(updatedDate);
    return map;
  }

  FolderTableCompanion toCompanion(bool nullToAbsent) {
    return FolderTableCompanion(
      id: Value(id),
      title: Value(title),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdDate: Value(createdDate),
      updatedDate: Value(updatedDate),
    );
  }

  factory FolderTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolderTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<Color?>(json['color']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<Color?>(color),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
    };
  }

  FolderTableData copyWith(
          {int? id,
          String? title,
          Color? color,
          DateTime? createdDate,
          DateTime? updatedDate}) =>
      FolderTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        color: color ?? this.color,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
  @override
  String toString() {
    return (StringBuffer('FolderTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, color, createdDate, updatedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolderTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.createdDate == this.createdDate &&
          other.updatedDate == this.updatedDate);
}

class FolderTableCompanion extends UpdateCompanion<FolderTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<Color?> color;
  final Value<DateTime> createdDate;
  final Value<DateTime> updatedDate;
  const FolderTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
  });
  FolderTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
  }) : title = Value(title);
  static Insertable<FolderTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<Color?>? color,
    Expression<DateTime>? createdDate,
    Expression<DateTime>? updatedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (createdDate != null) 'created_date': createdDate,
      if (updatedDate != null) 'updated_date': updatedDate,
    });
  }

  FolderTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<Color?>? color,
      Value<DateTime>? createdDate,
      Value<DateTime>? updatedDate}) {
    return FolderTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
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
    if (color.present) {
      final converter = $FolderTableTable.$converter0;
      map['color'] = Variable<int?>(converter.mapToSql(color.value));
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolderTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate')
          ..write(')'))
        .toString();
  }
}

class $FolderTableTable extends FolderTable
    with TableInfo<$FolderTableTable, FolderTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FolderTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumnWithTypeConverter<Color, int?> color =
      GeneratedColumn<int?>('color', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<Color>($FolderTableTable.$converter0);
  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  @override
  late final GeneratedColumn<DateTime?> createdDate =
      GeneratedColumn<DateTime?>('created_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  @override
  late final GeneratedColumn<DateTime?> updatedDate =
      GeneratedColumn<DateTime?>('updated_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, color, createdDate, updatedDate];
  @override
  String get aliasedName => _alias ?? 'folder_table';
  @override
  String get actualTableName => 'folder_table';
  @override
  VerificationContext validateIntegrity(Insertable<FolderTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_colorMeta, const VerificationResult.success());
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date']!, _createdDateMeta));
    }
    if (data.containsKey('updated_date')) {
      context.handle(
          _updatedDateMeta,
          updatedDate.isAcceptableOrUnknown(
              data['updated_date']!, _updatedDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FolderTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FolderTableTable createAlias(String alias) {
    return $FolderTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Color, int> $converter0 = const ColorConverter();
}

class SubtodoTableData extends DataClass
    implements Insertable<SubtodoTableData> {
  final int id;
  final String title;
  final bool completed;
  final int todoId;
  SubtodoTableData(
      {required this.id,
      required this.title,
      required this.completed,
      required this.todoId});
  factory SubtodoTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SubtodoTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      completed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completed'])!,
      todoId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    map['todo_id'] = Variable<int>(todoId);
    return map;
  }

  SubtodoTableCompanion toCompanion(bool nullToAbsent) {
    return SubtodoTableCompanion(
      id: Value(id),
      title: Value(title),
      completed: Value(completed),
      todoId: Value(todoId),
    );
  }

  factory SubtodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubtodoTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      todoId: serializer.fromJson<int>(json['todoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
      'todoId': serializer.toJson<int>(todoId),
    };
  }

  SubtodoTableData copyWith(
          {int? id, String? title, bool? completed, int? todoId}) =>
      SubtodoTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        todoId: todoId ?? this.todoId,
      );
  @override
  String toString() {
    return (StringBuffer('SubtodoTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('todoId: $todoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, completed, todoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubtodoTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.todoId == this.todoId);
}

class SubtodoTableCompanion extends UpdateCompanion<SubtodoTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  final Value<int> todoId;
  const SubtodoTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.todoId = const Value.absent(),
  });
  SubtodoTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
    required int todoId,
  })  : title = Value(title),
        todoId = Value(todoId);
  static Insertable<SubtodoTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? completed,
    Expression<int>? todoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
      if (todoId != null) 'todo_id': todoId,
    });
  }

  SubtodoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? completed,
      Value<int>? todoId}) {
    return SubtodoTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      todoId: todoId ?? this.todoId,
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
    if (todoId.present) {
      map['todo_id'] = Variable<int>(todoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubtodoTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('todoId: $todoId')
          ..write(')'))
        .toString();
  }
}

class $SubtodoTableTable extends SubtodoTable
    with TableInfo<$SubtodoTableTable, SubtodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubtodoTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _todoIdMeta = const VerificationMeta('todoId');
  @override
  late final GeneratedColumn<int?> todoId = GeneratedColumn<int?>(
      'todo_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, completed, todoId];
  @override
  String get aliasedName => _alias ?? 'subtodo_table';
  @override
  String get actualTableName => 'subtodo_table';
  @override
  VerificationContext validateIntegrity(Insertable<SubtodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('todo_id')) {
      context.handle(_todoIdMeta,
          todoId.isAcceptableOrUnknown(data['todo_id']!, _todoIdMeta));
    } else if (isInserting) {
      context.missing(_todoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubtodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SubtodoTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SubtodoTableTable createAlias(String alias) {
    return $SubtodoTableTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final Trigger todoUpdatedTimestamp = Trigger(
      'CREATE TRIGGER todo_updated_timestamp\r\n    AFTER UPDATE OF title, completed, date, time, folder_id, note\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET updated_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'todo_updated_timestamp');
  late final Trigger todoCompleted = Trigger(
      'CREATE TRIGGER todo_completed\r\n    AFTER UPDATE OF completed\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    WHEN new.completed == 1\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET completed_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'todo_completed');
  late final Trigger todoUncompleted = Trigger(
      'CREATE TRIGGER todo_uncompleted\r\n    AFTER UPDATE OF completed\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    WHEN new.completed == 0\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET completed_date = NULL\r\n        WHERE id = old.id;\r\n    END;',
      'todo_uncompleted');
  late final $FolderTableTable folderTable = $FolderTableTable(this);
  late final Trigger folderUpdatedTimestamp = Trigger(
      'CREATE TRIGGER folder_updated_timestamp\r\n    AFTER UPDATE OF title, color\r\n    ON folder_table\r\n    FOR EACH ROW\r\n    BEGIN\r\n        UPDATE folder_table\r\n        SET updated_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'folder_updated_timestamp');
  late final $SubtodoTableTable subtodoTable = $SubtodoTableTable(this);
  late final Trigger completeTodoBySubtodos = Trigger(
      'CREATE TRIGGER complete_todo_by_subtodos\r\n    AFTER UPDATE OF completed\r\n    ON subtodo_table\r\n    WHEN NEW.completed = true AND (SELECT COUNT(distinct completed) FROM subtodo_table WHERE todo_id = NEW.todo_id) = 1\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET completed = 1\r\n        WHERE id = new.todo_id;\r\n    END;',
      'complete_todo_by_subtodos');
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        todoTable,
        todoUpdatedTimestamp,
        todoCompleted,
        todoUncompleted,
        folderTable,
        folderUpdatedTimestamp,
        subtodoTable,
        completeTodoBySubtodos
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('todo_table',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('todo_table', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('todo_table',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('todo_table', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('todo_table',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('todo_table', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('folder_table',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('folder_table', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('subtodo_table',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('todo_table', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
