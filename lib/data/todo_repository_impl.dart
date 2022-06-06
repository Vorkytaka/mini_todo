import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay, DateUtils;
import 'package:mini_todo/data/database/table/todo_table.dart';

import '../entity/todo.dart';
import 'database/database.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Database database;

  const TodoRepositoryImpl({
    required this.database,
  });

  @override
  Future<Todo> create(TodoCarcase todo) {
    final query = database.into(database.todoTable);
    return query
        .insertReturning(
          TodoTableCompanion.insert(
            title: todo.title,
            date: Value(todo.date),
            time: Value(todo.time),
            folderId: Value(todo.folderId),
          ),
        )
        .then((value) => value.toTodo);
  }

  @override
  Future<int> setCompleted(int id, bool completed) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(TodoTableCompanion(completed: Value(completed)));
  }

  @override
  Stream<Todo?> streamConcreteTodo(int id) {
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.map((todo) => todo.toTodo).watchSingleOrNull();
  }

  @override
  Future<int> setTitle(int id, String title) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(TodoTableCompanion(title: Value(title)));
  }

  @override
  Future<int> setDate(int id, DateTime date) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(TodoTableCompanion(date: Value(date)));
  }

  @override
  Future<int> removeDate(int id) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(const TodoTableCompanion(date: Value(null), time: Value(null)));
  }

  @override
  Future<int> setTime(int id, TimeOfDay time) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(TodoTableCompanion(time: Value(time)));
  }

  @override
  Future<int> removeTime(int id) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(const TodoTableCompanion(time: Value(null)));
  }

  @override
  Future<int> updateNote(int id, String note) {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.write(TodoTableCompanion(note: Value(note)));
  }

  @override
  Future<int> delete(int id) {
    final query = database.delete(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.go();
  }

  @override
  Stream<List<Todo>> streamTodosFromFolder(int? folderId) {
    final query = database.select(database.todoTable);
    query.where((tbl) {
      if (folderId == null) return tbl.folderId.isNull();
      return tbl.folderId.equals(folderId);
    });
    query.where((tbl) => tbl.completed.not());
    return query.map((todo) => todo.toTodo).watch();
  }

  @override
  Stream<List<Todo>> streamCompletedTodoFromFolder(int? folderId) {
    final query = database.select(database.todoTable);
    query.where((tbl) {
      if (folderId == null) return tbl.folderId.isNull();
      return tbl.folderId.equals(folderId);
    });
    query.where((tbl) => tbl.completed);
    query.limit(10);
    query.orderBy([(t) => OrderingTerm(expression: t.completedDate, mode: OrderingMode.desc)]);
    return query.map((todo) => todo.toTodo).watch();
  }

  @override
  Future<int> updateFolder(int todoId, int? folderId) async {
    final query = database.update(database.todoTable);
    query.where((tbl) => tbl.id.equals(todoId));
    return query.write(TodoTableCompanion(folderId: Value(folderId)));
  }

  @override
  Stream<List<Todo>> streamTodayTodo() {
    final today = DateUtils.dateOnly(DateTime.now());
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.date.equalsValue(today) & tbl.completed.not());
    return query.map((p0) => p0.toTodo).watch();
  }

  @override
  Stream<List<Todo>> streamTodayOverdue() {
    final today = DateUtils.dateOnly(DateTime.now());
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.date.isSmallerThanDartValue(today) & tbl.completed.not());
    return query.map((p0) => p0.toTodo).watch();
  }

  @override
  Future<Todo?> readById(int id) {
    final query = database.select(database.todoTable);
    query.where((tbl) => tbl.id.equals(id));
    return query.getSingleOrNull().then((value) => value?.toTodo);
  }
}

extension on GeneratedColumnWithTypeConverter<DateTime, int?> {
  Expression<bool?> isSmallerThanDartValue(DateTime dartValue) {
    final ms = converter.mapToSql(dartValue) as int;
    return isSmallerThanValue(ms);
  }
}
