import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_todo/data/repository.dart';

import '../../entity/folder.dart';
import '../../entity/todo.dart';

class FolderCubit extends Cubit<FolderState> {
  StreamSubscription? _todosSubscription;
  StreamSubscription? _completedSubscription;

  FolderCubit({
    required Folder folder,
    required Repository repository,
  }) : super(FolderState.init(folderId: folder.id)) {
    _todosSubscription = repository.streamTodoFromFolder(state.folderId).listen((todos) {
      emit(state.copyWith(todos: todos));
    });
    _completedSubscription = repository.streamCompletedTodoFromFolder(state.folderId).listen((completed) {
      emit(state.copyWith(completed: completed));
    });
  }

  @override
  Future<void> close() async {
    await _todosSubscription?.cancel();
    await _completedSubscription?.cancel();
    return super.close();
  }
}

@immutable
class FolderState {
  final int? folderId;
  final List<Todo> todos;
  final List<Todo> completed;

  const FolderState({
    required this.folderId,
    required this.todos,
    required this.completed,
  });

  const FolderState.init({
    required this.folderId,
  })
      : todos = const [],
        completed = const [];

  FolderState copyWith({
    List<Todo>? todos,
    List<Todo>? completed,
  }) =>
      FolderState(
        folderId: folderId,
        todos: todos ?? this.todos,
        completed: completed ?? this.completed,
      );

  bool get isEmpty => todos.isEmpty && completed.isEmpty;
}
