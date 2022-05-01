import 'dart:async';

import 'package:drift/drift.dart';
import 'package:mini_todo/data/database/database.dart';

import '../entity/todo.dart';

abstract class Repository {
  Future<int> create(TodoCarcase todo);

  Stream<List<Todo>> streamAll();

  Future<int> setCompleted(int id, bool completed);

  Stream<Todo?> streamTodo(int id);
}

class SqlRepository implements Repository {
  final Database database;

  const SqlRepository({
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
        TodoTableCompanion(
          completed: Value(completed),
        ),
      );

  @override
  Stream<List<Todo>> streamAll() => (database.select(database.todoTable)..where((tbl) => tbl.completed.not()))
      .map((todo) => Todo(
            id: todo.id,
            title: todo.title,
            completed: todo.completed,
            date: todo.date,
            time: todo.time,
            createdDate: todo.createdDate,
          ))
      .watch();

  @override
  Stream<Todo?> streamTodo(int id) => (database.select(database.todoTable)..where((tbl) => tbl.id.equals(id)))
      .map((todo) => Todo(
            id: todo.id,
            title: todo.title,
            completed: todo.completed,
            date: todo.date,
            time: todo.time,
            createdDate: todo.createdDate,
          ))
      .watchSingle();
}
