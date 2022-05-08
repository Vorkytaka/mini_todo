import 'package:flutter/material.dart';

import '../current_time_widget.dart';
import '../entity/todo.dart';
import 'todo_list/todo_list_screen.dart';

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
      style: theme.textTheme.subtitle1!.apply(
        decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
      ),
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

    final Widget checkbox = TodoCheckbox(todo: todo);

    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

    Widget body = Material(
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
    );

    if (todo.completed) {
      body = Opacity(
        opacity: 0.8,
        child: body,
      );
    }

    return SizedBox(
      height: 56,
      child: body,
    );
  }
}