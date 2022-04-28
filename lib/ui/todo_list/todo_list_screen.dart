import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/domain/todo/todo_list_cubit.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/todo_detailed/todo_detailed_screen.dart';

import '../../current_time_widget.dart';
import '../../entity/todo.dart';
import '../new_todo.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

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
        title: Text(S.of(context).common__inbox),
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
                sliver: BlocBuilder<TodoListCubit, List<Todo>>(builder: (context, todos) {
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
                                  builder: (context) => TodoDetailedScreen(id: todo.id),
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
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTap;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // todo: line through when completed
    final Widget titleWidget = AnimatedDefaultTextStyle(
      style: theme.textTheme.subtitle1!,
      duration: kThemeChangeDuration,
      child: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    Widget? datetimeWidget;
    if (todo.date != null) {
      datetimeWidget = DatetimeOnNowWidget(
        date: todo.date!,
        time: todo.time,
      );
    }

    final Widget checkbox = Checkbox(
      value: todo.completed,
      onChanged: (_) {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
    );

    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

    return SizedBox(
      height: 56,
      child: Material(
        color: Colors.grey.shade100,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      titleWidget,
                      if (datetimeWidget != null) ...[
                        const SizedBox(height: 2),
                        datetimeWidget,
                      ],
                    ],
                  ),
                ),
                checkbox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
