// GENERATED CODE, DO NOT EDIT BY HAND.
//@dart=2.12
import 'package:drift/drift.dart';

class TodoTable extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TodoTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
  late final GeneratedColumn<int?> date = GeneratedColumn<int?>(
      'date', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  late final GeneratedColumn<int?> time = GeneratedColumn<int?>(
      'time', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  late final GeneratedColumn<DateTime?> createdDate =
      GeneratedColumn<DateTime?>('created_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  late final GeneratedColumn<DateTime?> updatedDate =
      GeneratedColumn<DateTime?>('updated_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  late final GeneratedColumn<DateTime?> completedDate =
      GeneratedColumn<DateTime?>('completed_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  late final GeneratedColumn<int?> folderId = GeneratedColumn<int?>(
      'folder_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
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
        note
      ];
  @override
  String get aliasedName => _alias ?? 'todo_table';
  @override
  String get actualTableName => 'todo_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  TodoTable createAlias(String alias) {
    return TodoTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => false;
}

class FolderTable extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  FolderTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  late final GeneratedColumn<DateTime?> createdDate =
      GeneratedColumn<DateTime?>('created_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  FolderTable createAlias(String alias) {
    return FolderTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => false;
}

class SubtodoTable extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SubtodoTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  late final GeneratedColumn<bool?> completed = GeneratedColumn<bool?>(
      'completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (completed IN (0, 1))',
      defaultValue: const Constant(false));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  SubtodoTable createAlias(String alias) {
    return SubtodoTable(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => false;
}

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final TodoTable todoTable = TodoTable(this);
  late final Trigger todoUpdatedTimestamp = Trigger(
      'CREATE TRIGGER todo_updated_timestamp\r\n    AFTER UPDATE OF title, completed, date, time, folder_id, note\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET updated_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'todo_updated_timestamp');
  late final Trigger todoCompleted = Trigger(
      'CREATE TRIGGER todo_completed\r\n    AFTER UPDATE OF completed\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    WHEN new.completed == 1\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET completed_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'todo_completed');
  late final Trigger todoUncompleted = Trigger(
      'CREATE TRIGGER todo_uncompleted\r\n    AFTER UPDATE OF completed\r\n    ON todo_table\r\n    FOR EACH ROW\r\n    WHEN new.completed == 0\r\n    BEGIN\r\n        UPDATE todo_table\r\n        SET completed_date = NULL\r\n        WHERE id = old.id;\r\n    END;',
      'todo_uncompleted');
  late final FolderTable folderTable = FolderTable(this);
  late final Trigger folderUpdatedTimestamp = Trigger(
      'CREATE TRIGGER folder_updated_timestamp\r\n    AFTER UPDATE OF title, color\r\n    ON folder_table\r\n    FOR EACH ROW\r\n    BEGIN\r\n        UPDATE folder_table\r\n        SET updated_date = strftime(\'%s\', CURRENT_TIMESTAMP)\r\n        WHERE id = old.id;\r\n    END;',
      'folder_updated_timestamp');
  late final SubtodoTable subtodoTable = SubtodoTable(this);
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
        subtodoTable
      ];
  @override
  int get schemaVersion => 1;
}
