import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/entity/todo.dart';

class TodoListCubit extends Cubit<List<Todo>> {
  final Repository repository;
  StreamSubscription? _subscription;

  TodoListCubit({
    required this.repository,
  }) : super(const []) {
    _subscription = repository.streamAll().listen((todos) {
      emit(todos.toList(growable: false));
    });
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    super.close();
  }
}
