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
  }) : super(FolderState.init(folder: folder)) {
    _todosSubscription = repository.streamTodoFromFolder(state.folder.id).listen((todos) {
      emit(state.copyWith(todos: todos));
    });
    _completedSubscription = repository.streamCompletedTodoFromFolder(state.folder.id).listen((completed) {
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
  final Folder folder;
  final List<Todo> todos;
  final List<Todo> completed;

  const FolderState({
    required this.folder,
    required this.todos,
    required this.completed,
  });

  const FolderState.init({
    required this.folder,
  })
      : todos = const [],
        completed = const [];

  FolderState copyWith({
    Folder? folder,
    List<Todo>? todos,
    List<Todo>? completed,
  }) =>
      FolderState(
        folder: folder ?? this.folder,
        todos: todos ?? this.todos,
        completed: completed ?? this.completed,
      );

  bool get isEmpty => todos.isEmpty && completed.isEmpty;
}
