import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/ui/select_date.dart';
import 'package:mini_todo/ui/todo_list/todo_list_screen.dart';

import '../../data/repository.dart';
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
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<Todo?>(
        stream: context.read<Repository>().streamTodo(id),
        initialData: null,
        builder: (context, snapshot) {
          final todo = snapshot.data;

          if (todo == null) {
            return const SizedBox.shrink();
          }

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AppBar(todo: todo),
              NowStyle(
                date: todo.date,
                time: todo.time,
                textStyle: Theme.of(context).textTheme.subtitle1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () async {
                        final date = await showDateSelector(
                          context: context,
                          selectedDate: todo.date,
                        );
                        if (date != null) {
                          context.read<Repository>().setDate(todo.id, date);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SizedBox(
                          height: 56,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.today),
                              const SizedBox(width: 16),
                              todo.date != null ? DateTextWidget(date: todo.date!) : const Text('Без даты'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: todo.date == null,
                      child: InkWell(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: todo.time ?? const TimeOfDay(hour: 12, minute: 00),
                          );
                          if (time != null) {
                            context.read<Repository>().setTime(todo.id, time);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SizedBox(
                            height: 56,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_outlined),
                                const SizedBox(width: 16),
                                todo.time != null ? Text(todo.time!.format(context)) : const Text('Без времени'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                indent: 64,
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
      context.read<Repository>().setTitle(widget.todo.id, _titleController.text);
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
