import 'dart:async';

import 'package:flutter/material.dart';

import '../entity/todo.dart';

abstract class TodoRepository {
  Future<int> create(TodoCarcase todo);

  Future<int> setCompleted(int id, bool completed);

  Stream<Todo?> streamConcreteTodo(int id);

  Future<int> setTitle(int id, String title);

  Future<int> setDate(int id, DateTime date);

  Future<int> removeDate(int id);

  Future<int> setTime(int id, TimeOfDay time);

  Future<int> removeTime(int id);

  Future<int> updateNote(int id, String note);

  Future<int> delete(int id);

  Stream<List<Todo>> streamTodosFromFolder(int? folderId);

  Stream<List<Todo>> streamCompletedTodoFromFolder(int? folderId);

  Future<int> updateFolder(int todoId, int? folderId);

  Stream<List<Todo>> streamTodayTodo();

  Stream<List<Todo>> streamTodayOverdue();
}
