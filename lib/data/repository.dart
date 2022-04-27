import 'dart:async';

import '../entity/todo.dart';

abstract class Repository {
  Future<void> create(Todo todo);

  Future<List<Todo>> readAll();

  Stream<List<Todo>> streamAll();

  Future<void> update(Todo todo);

  Future<void> delete(Todo todo);
}

class TestRepository extends Repository {
  final List<Todo> _todos = List.empty();
  final StreamController<List<Todo>> _controller = StreamController.broadcast();

  TestRepository() {
    _controller.add(_todos);
  }

  @override
  Future<void> create(Todo todo) async {
    if (!_todos.contains(todo)) {
      _todos.add(todo);
    }
    _controller.add(_todos);
  }

  @override
  Future<List<Todo>> readAll() async {
    return _todos;
  }

  @override
  Stream<List<Todo>> streamAll() {
    return _controller.stream;
  }

  @override
  Future<void> update(Todo todo) async {
    final id = _todos.indexWhere((t) => t.id == todo.id);
    _todos[id] = todo;
    _controller.add(_todos);
  }

  @override
  Future<void> delete(Todo todo) async {
    _todos.removeWhere((t) => t.id == todo.id);
    _controller.add(_todos);
  }
}
