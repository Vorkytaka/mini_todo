import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/formatter.dart';
import 'package:mini_todo/ui/gradient_body.dart';
import 'package:mini_todo/ui/todo_list.dart';
import 'package:mini_todo/utils/color.dart';

import '../../current_time_widget.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        toggleableActiveColor: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Сегодня'),
              const SizedBox(height: 4),
              Text(
                dateFormatter.format(CurrentTime.of(context)),
                style: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.white),
              ),
            ],
          ),
        ),
        body: GradientBody(
          color: Colors.green.lighten(70),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              const SliverToBoxAdapter(
                child: Center(
                  child: TodoListHeader(
                    child: Text('Сегодня'),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: StreamBuilder<List<Todo>>(
                  initialData: const [],
                  stream: context.read<Repository>().streamTodayTodo(),
                  builder: (context, snapshot) => TodoList(todos: snapshot.data!),
                ),
              ),
              const SliverToBoxAdapter(
                child: Center(
                  child: TodoListHeader(
                    child: Text('Просроченные'),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: StreamBuilder<List<Todo>>(
                  initialData: const [],
                  stream: context.read<Repository>().streamOverdueByToday(),
                  builder: (context, snapshot) => TodoList(todos: snapshot.data!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
