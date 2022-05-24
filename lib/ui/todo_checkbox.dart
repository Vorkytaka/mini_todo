import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/todo_repository.dart';
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
      onChanged: (completed) {
        setState(() {
          _completed = completed!;
        });
        context.read<TodoRepository>().setCompleted(widget.todo.id, _completed);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
