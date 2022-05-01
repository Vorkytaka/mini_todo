import 'dart:async';

import 'package:flutter/material.dart';

import '../entity/todo.dart';

abstract class Repository {
  Future<int> create(TodoCarcase todo);

  Stream<List<Todo>> streamAll();

  Stream<List<Todo>> streamAllCompleted();

  Future<int> setCompleted(int id, bool completed);

  Stream<Todo?> streamTodo(int id);

  Future<int> setTitle(int id, String title);

  Future<int> setDate(int id, DateTime date);

  Future<int> setTime(int id, TimeOfDay time);
}
