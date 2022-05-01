import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;

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
      );
}
