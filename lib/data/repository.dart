import 'dart:async';

import 'package:drift/drift.dart';
import 'package:mini_todo/data/database/database.dart';

import '../entity/todo.dart';

abstract class Repository {
  Future<int> create(TodoCarcase todo);

  Stream<List<Todo>> streamAll();

  Future<void> update(Todo todo);

  Future<void> delete(Todo todo);

  Future<void> setCompleted(int id, bool completed);
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
  Future<void> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> setCompleted(int id, bool completed) {
    // TODO: implement setCompleted
    throw UnimplementedError();
  }

  @override
  Stream<List<Todo>> streamAll() {
    return database
        .select(database.todoTable)
        .map((todo) => Todo(
              id: todo.id,
              title: todo.title,
              completed: todo.completed,
              date: todo.date,
              time: todo.time,
              createdDate: todo.createdDate,
            ))
        .watch();
  }

  @override
  Future<void> update(Todo todo) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
