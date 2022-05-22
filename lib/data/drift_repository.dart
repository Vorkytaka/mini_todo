import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay, DateUtils;
import 'package:mini_todo/data/database/table/subtodo_table.dart';
import 'package:mini_todo/data/database/table/todo_table.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/entity/subtodo.dart';

import '../entity/todo.dart';
import 'database/database.dart';
import 'database/table/folder_table.dart';
import 'repository.dart';

class DriftRepository implements Repository {
  final Database database;

  const DriftRepository({
    required this.database,
  });

  @override
  Future<int> create(TodoCarcase todo) => database.into(database.todoTable).insert(
        TodoTableCompanion.insert(
          title: todo.title,
          date: Value(todo.date),
          time: Value(todo.time),
          folderId: Value(todo.folderId),
        ),
      );

  @override
  Future<int> setCompleted(int id, bool completed) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(completed: Value(completed)),
      );

  @override
  Stream<List<Todo>> streamAll() =>
      (database.select(database.todoTable)..where((tbl) => tbl.completed.not())).map((todo) => todo.toTodo).watch();

  @override
  Stream<List<Todo>> streamAllCompleted() =>
      (database.select(database.todoTable)..where((tbl) => tbl.completed)).map((todo) => todo.toTodo).watch();

  @override
  Stream<Todo?> streamTodo(int id) =>
      (database.select(database.todoTable)..where((tbl) => tbl.id.equals(id))).map((todo) => todo.toTodo).watchSingle();

  @override
  Future<int> setTitle(int id, String title) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(title: Value(title)),
      );

  @override
  Future<int> setDate(int id, DateTime date) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(date: Value(date)),
      );

  @override
  Future<int> removeDate(int id) => (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        const TodoTableCompanion(date: Value(null), time: Value(null)),
      );

  @override
  Future<int> setTime(int id, TimeOfDay time) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(time: Value(time)),
      );

  @override
  Future<int> removeTime(int id) => (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        const TodoTableCompanion(time: Value(null)),
      );

  @override
  Future<int> setNote(int id, String note) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(note: Value(note)),
      );

  @override
  Future<int> delete(int id) => (database.delete(database.todoTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  Future<int> createFolder(FolderCarcass folder) async => database.into(database.folderTable).insert(
        FolderTableCompanion.insert(
          title: folder.title,
          color: Value(folder.color),
        ),
      );

  @override
  Stream<List<Folder>> streamAllFolder() {
    // todo: use counting
    final query = database.select(database.folderTable).join([
      leftOuterJoin(
        database.todoTable,
        database.todoTable.id.equalsExp(database.folderTable.id),
        useColumns: false,
      ),
    ]);
    query.addColumns([database.todoTable.id.count()]);
    query.groupBy([database.folderTable.id]);
    return query.map((p0) => p0.readTable(database.folderTable).toFolder).watch();
  }

  @override
  Stream<List<Todo>> streamTodoFromFolder(int? folderId) => (database.select(database.todoTable)
        ..where((tbl) {
          if (folderId == null) return tbl.folderId.isNull();
          return tbl.folderId.equals(folderId);
        })
        ..where((tbl) => tbl.completed.not()))
      .map((todo) => todo.toTodo)
      .watch();

  @override
  Stream<List<Todo>> streamCompletedTodoFromFolder(int? folderId) => (database.select(database.todoTable)
        ..where((tbl) {
          if (folderId == null) return tbl.folderId.isNull();
          return tbl.folderId.equals(folderId);
        })
        ..where((tbl) => tbl.completed)
        ..limit(10))
      .map((todo) => todo.toTodo)
      .watch();

  @override
  Future<int> deleteFolder(int folderId, bool deleteTodos) async {
    return database.transaction(() async {
      if (deleteTodos) {
        final query = database.delete(database.todoTable);
        query.where((tbl) => tbl.folderId.equals(folderId));
        await query.go();
      } else {
        final query = database.update(database.todoTable);
        query.where((tbl) => tbl.folderId.equals(folderId));
        await query.write(const TodoTableCompanion(folderId: Value(null)));
      }

      final query = database.delete(database.folderTable);
      query.where((tbl) => tbl.id.equals(folderId));
      return query.go();
    });
  }

  @override
  Future<int> changeTodoFolder(int todoId, int? folderId) async {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(todoId));
    return query.write(TodoTableCompanion(folderId: Value(folderId)));
  }

  @override
  Future<int> updateFolder(Folder folder) async {
    assert(folder.id != null);
    final query = database.update(database.folderTable);
    query.where((tbl) => tbl.id.equals(folder.id));
    return query.write(FolderTableCompanion(
      title: Value(folder.title),
      color: Value(folder.color),
    ));
  }

  @override
  Stream<List<Todo>> streamTodayTodo() {
    final today = DateUtils.dateOnly(DateTime.now());
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.date.equalsValue(today) & tbl.completed.not());
    return query.map((p0) => p0.toTodo).watch();
  }

  @override
  Stream<List<Todo>> streamOverdueByToday() {
    final today = DateUtils.dateOnly(DateTime.now());
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.date.isSmallerThanDartValue(today) & tbl.completed.not());
    return query.map((p0) => p0.toTodo).watch();
  }

  @override
  Stream<List<Subtodo>> streamSubtodoByTodo(int todoId) {
    final query = database.select(database.subtodoTable);
    query.where((tbl) => tbl.todoId.equals(todoId));
    return query.map((p0) => p0.toSubtodo).watch();
  }

  @override
  Future<int> createSubtodoForTodo(int todoId) {
    return database.into(database.subtodoTable).insert(
          SubtodoTableCompanion.insert(
            title: '',
            todoId: todoId,
          ),
        );
  }

  @override
  Future<int> changeSubtodoTitle(int id, String title) {
    final query = database.update(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(SubtodoTableCompanion(title: Value(title)));
  }

  @override
  Future<int> changeSubtodoCompleted(int id, bool completed) {
    final query = database.update(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(SubtodoTableCompanion(completed: Value(completed)));
  }

  @override
  Future<int> deleteSubtodo(int id) async {
    final query = database.delete(database.subtodoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.go();
  }
}

extension on GeneratedColumnWithTypeConverter<DateTime, int?> {
  Expression<bool?> isSmallerThanDartValue(DateTime dartValue) {
    final ms = converter.mapToSql(dartValue) as int;
    return isSmallerThanValue(ms);
  }
}
