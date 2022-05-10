import 'package:flutter/material.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/todo_item.dart';
import 'package:mini_todo/utils/collections.dart';

import 'todo_detailed/todo_detailed_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({
    Key? key,
    required this.todos,
  }) : super(key: key);

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
        childCount: countChildWithSeparators(todos.length),
      ),
    );
  }
}
