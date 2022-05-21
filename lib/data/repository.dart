import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/entity/subtodo.dart';

import '../entity/todo.dart';

abstract class Repository {
  Future<int> create(TodoCarcase todo);

  Stream<List<Todo>> streamAll();

  Stream<List<Todo>> streamAllCompleted();

  Future<int> setCompleted(int id, bool completed);

  Stream<Todo?> streamTodo(int id);

  Future<int> setTitle(int id, String title);

  Future<int> setDate(int id, DateTime date);

  Future<int> removeDate(int id);

  Future<int> setTime(int id, TimeOfDay time);

  Future<int> removeTime(int id);

  Future<int> setNote(int id, String note);

  Future<int> delete(int id);

  Future<int> createFolder(FolderCarcass folder);

  Stream<List<Folder>> streamAllFolder();

  Stream<List<Todo>> streamTodoFromFolder(int? folderId);

  Stream<List<Todo>> streamCompletedTodoFromFolder(int? folderId);

  Future<int> deleteFolder(int folderId, bool deleteTodos);

  Future<int> changeTodoFolder(int todoId, int? folderId);

  Future<int> updateFolder(Folder folder);

  Stream<List<Todo>> streamTodayTodo();

  Stream<List<Todo>> streamOverdueByToday();

  Stream<List<Subtodo>> streamSubtodoByTodo(int todoId);

  Future<int> createSubtodoForTodo(int todoId);

  Future<int> changeSubtodoTitle(int id, String title);

  Future<int> changeSubtodoCompleted(int id, bool completed);

  Future<int> deleteSubtodo(int id);
}
