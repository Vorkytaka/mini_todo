import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/todo_detailed/todo_detailed_screen.dart';

import '../../entity/todo.dart';
import '../new_todo.dart';
import '../todo_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightBlue.shade100,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showNewTodoDialog(context: context);
          },
          child: const Icon(Icons.add),
        );
      }),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.lightBlue,
        title: Text(S.of(context).app_name),
        centerTitle: true,
      ),
      body: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.shade100,
              Colors.lightBlue.shade50,
            ],
            stops: const [0.25, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: StreamBuilder<List<Todo>>(
                  stream: context.read<Repository>().streamAll(),
                  builder: (context, snapshot) {
                    final todos = snapshot.data;

                    if (todos == null) {
                      return const SliverToBoxAdapter();
                    }

                    return TodoListSliver(todos: todos);
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Material(
                      color: Colors.grey.shade100,
                      borderRadius: borderRadius,
                      child: InkWell(
                        onTap: () => setState(() {
                          _showCompleted = !_showCompleted;
                        }),
                        borderRadius: borderRadius,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(_showCompleted
                              ? S.of(context).common_hide_completed
                              : S.of(context).common_show_completed),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showCompleted)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: StreamBuilder<List<Todo>>(
                    stream: context.read<Repository>().streamAllCompleted(),
                    builder: (context, snapshot) {
                      final todos = snapshot.data;

                      if (todos == null) {
                        return const SliverToBoxAdapter();
                      }

                      return TodoListSliver(todos: todos);
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class TodoListSliver extends StatelessWidget {
  final List<Todo> todos;

  const TodoListSliver({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          final int itemIndex = i ~/ 2;

          if (i.isEven) {
            final todo = todos[itemIndex];
            return TodoItemWidget(
              todo: todo,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TodoDetailedScreen(todo: todo),
                  ),
                );
              },
            );
          }

          // divider
          return const SizedBox(height: 2);
        },
        childCount: math.max(0, todos.length * 2 - 1),
      ),
    );
  }
}

class TodoCheckbox extends StatelessWidget {
  final Todo todo;

  const TodoCheckbox({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: todo.completed,
      onChanged: (completed) => context.read<Repository>().setCompleted(todo.id, completed!),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }
}
