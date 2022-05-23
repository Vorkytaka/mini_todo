import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/todo_item.dart';

import 'todo_detailed/todo_detailed_screen.dart';

class TodoListHeader extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const TodoListHeader({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      color: Colors.grey.shade100,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodySmall!,
            child: child,
          ),
        ),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  final List<Todo> todos;

  const TodoList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final controller = AnimatedListController();
  late final AnimatedListDiffListDispatcher dispatcher;

  @override
  void initState() {
    super.initState();
    dispatcher = AnimatedListDiffListDispatcher<Todo>(
      controller: controller,
      itemBuilder: itemBuilder,
      currentList: widget.todos,
      comparator: AnimatedListDiffListComparator<Todo>(
        sameItem: (a, b) => a.id == b.id,
        sameContent: (a, b) => a == b,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TodoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    dispatcher.dispatchNewList(widget.todos);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSliverList(
      delegate: AnimatedSliverChildBuilderDelegate(
        (context, i, data) => itemBuilder(context, dispatcher.currentList[i], data),
        dispatcher.currentList.length,
        animator: const DefaultAnimatedListAnimator(
          dismissIncomingDuration: Duration(milliseconds: 500),
          resizeDuration: Duration(milliseconds: 150),
        ),
        addLongPressReorderable: false,
      ),
      controller: controller,
    );
  }

  Widget itemBuilder(BuildContext context, Todo todo, AnimatedWidgetBuilderData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: TodoItemWidget(
        todo: todo,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoDetailedScreen(todo: todo),
            ),
          );
        },
      ),
    );
  }
}
