import 'package:flutter/material.dart';
import 'package:mini_todo/domain/use_case.dart';

import '../entity/todo.dart';

class TodoCheckbox extends StatefulWidget {
  final Todo todo;

  const TodoCheckbox({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoCheckbox> createState() => _TodoCheckboxState();
}

class _TodoCheckboxState extends State<TodoCheckbox> {
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _completed = widget.todo.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _completed,
      tristate: false,
      onChanged: (completed) async {
        setState(() => _completed = completed!);
        await completeTodo(context, widget.todo.id, _completed);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
