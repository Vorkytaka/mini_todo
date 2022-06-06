import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/todo_repository.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/common/gradient_body.dart';
import 'package:mini_todo/ui/formatter.dart';
import 'package:mini_todo/ui/todo_list.dart';
import 'package:mini_todo/utils/color.dart';

import '../../current_time_widget.dart';
import '../../generated/l10n.dart';
import '../new_todo.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    final appBar = AppBar(
      centerTitle: false,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.folder__today),
          const SizedBox(height: 4),
          Text(
            dateFormatter.format(CurrentTime.of(context)),
            style: theme.textTheme.titleMedium?.apply(color: Colors.white),
          ),
        ],
      ),
    );

    Widget body = CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: TodoListHeader(
              child: Text(s.folder__today),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: StreamBuilder<List<Todo>>(
            initialData: const [],
            stream: context.read<TodoRepository>().streamTodayTodo(),
            builder: (context, snapshot) {
              if(snapshot.data!.isEmpty) return const SliverToBoxAdapter();
              return TodoList(todos: snapshot.data!);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: TodoListHeader(
              child: Text(s.today_screen__overdue),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: StreamBuilder<List<Todo>>(
            initialData: const [],
            stream: context.read<TodoRepository>().streamTodayOverdue(),
            builder: (context, snapshot) {
              if(snapshot.data!.isEmpty) return const SliverToBoxAdapter();
              return TodoList(todos: snapshot.data!);
            },
          ),
        ),
      ],
    );

    body = GradientBody(
      color: Colors.green.lighten(70),
      child: body,
    );

    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        toggleableActiveColor: Colors.green,
      ),
      child: Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showNewTodoDialog(context: context, date: DateTime.now()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
