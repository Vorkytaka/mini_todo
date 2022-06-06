import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/todo_repository.dart';
import 'package:mini_todo/entity/todo.dart';

class TodoDetailedCubit extends Cubit<TodoDetailedState> {
  StreamSubscription? _todoStream;

  TodoDetailedCubit({
    required int todoId,
    required TodoRepository todoRepository,
  }) : super(const TodoDetailedState(todo: null, initialized: false)) {
    _todoStream = todoRepository.streamConcreteTodo(todoId).listen((todo) {
      emit(TodoDetailedState(todo: todo, initialized: true));
    });
  }

  @override
  Future<void> close() async {
    await _todoStream?.cancel();
    return super.close();
  }
}

class TodoDetailedState {
  final Todo? todo;
  final bool initialized;

  const TodoDetailedState({
    required this.todo,
    required this.initialized,
  });

  bool get hasTodo => !initialized || todo != null;
}
