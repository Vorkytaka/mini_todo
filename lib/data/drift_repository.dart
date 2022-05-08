import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:mini_todo/entity/folder.dart';

import '../entity/todo.dart';
import 'database/database.dart';
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
  Future<int> setTime(int id, TimeOfDay time) =>
      (database.update(database.todoTable)..where((tbl) => tbl.id.equals(id))).write(
        TodoTableCompanion(time: Value(time)),
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
  Stream<List<Folder>> streamAllFolder() =>
      (database.select(database.folderTable)).map((folder) => folder.toFolder).watch();

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
}

extension on TodoTableData {
  Todo get toTodo => Todo(
        id: id,
        title: title,
        completed: completed,
        date: date,
        time: time,
        createdDate: createdDate,
        updatedDate: updatedDate,
        folderId: folderId,
      );
}

extension on FolderTableData {
  Folder get toFolder => Folder(
        id: id,
        title: title,
        color: color,
      );
}
