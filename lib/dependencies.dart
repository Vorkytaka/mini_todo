import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/database/database.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/domain/todo/todo_list_cubit.dart';

import 'current_time_widget.dart';

class OuterDependencies extends StatelessWidget {
  final Widget child;

  const OuterDependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => SqlRepository(database: Database()),
      child: BlocProvider(
        create: (context) => TodoListCubit(repository: context.read()),
        lazy: false,
        child: child,
      ),
    );
  }
}

class InnerDependencies extends StatelessWidget {
  final Widget child;

  const InnerDependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurrentTimeUpdater(
      duration: const Duration(seconds: 30),
      child: ScrollConfiguration(
        behavior: const _ScrollBehavior(),
        child: child,
      ),
    );
  }
}

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior() : super();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
