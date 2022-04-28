import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/domain/todo/todo_list_cubit.dart';
import 'package:mini_todo/ui/formatter.dart';
import 'package:mini_todo/ui/todo_list/todo_list_screen.dart';

import '../../entity/todo.dart';

class TodoDetailedScreen extends StatelessWidget {
  final int id;

  const TodoDetailedScreen({
    Key? key,
    required this.id,
  })  : assert(id > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<TodoListCubit, List<Todo>, Todo>(
        selector: (todos) => todos.firstWhere((todo) => todo.id == id),
        builder: (context, todo) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AppBar(todo: todo),
              if (todo.date != null)
                ListTile(
                  leading: const Icon(Icons.today),
                  title: Text(dateFormatter.format(todo.date!)),
                  onTap: () {},
                  dense: true,
                )
              else
                ListTile(
                  leading: const Icon(Icons.today),
                  title: const Text('Без даты'),
                  onTap: () {},
                  dense: true,
                ),
              if (todo.time != null)
                ListTile(
                  leading: const Icon(Icons.access_time_outlined),
                  title: Text(todo.time!.format(context)),
                  onTap: () {},
                  dense: true,
                )
              else
                ListTile(
                  leading: const Icon(Icons.access_time_outlined),
                  title: const Text('Без времени'),
                  onTap: () {},
                  dense: true,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AppBar extends StatefulWidget {
  final Todo todo;

  const _AppBar({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _titleController.addListener(() {
      context.read<Repository>().update(widget.todo.copyWith(title: _titleController.text));
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        elevation: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: kToolbarHeight),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BackButton(),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ),
              TodoCheckbox(todo: widget.todo),
            ],
          ),
        ),
      ),
    );
  }
}
