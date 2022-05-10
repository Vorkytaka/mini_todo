import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_todo/entity/folder.dart';

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

  Future<int> delete(int id);

  Future<int> createFolder(FolderCarcass folder);

  Stream<List<Folder>> streamAllFolder();

  Stream<List<Todo>> streamTodoFromFolder(int? folderId);

  Stream<List<Todo>> streamCompletedTodoFromFolder(int? folderId);

  Future<int> deleteFolder(int folderId, bool deleteTodos);

  Future<int> changeTodoFolder(int todoId, int? folderId);

  Future<int> updateFolder(Folder folder);
}
