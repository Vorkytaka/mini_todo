import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/list_item.dart';
import 'package:mini_todo/ui/select_date.dart';
import 'package:mini_todo/ui/select_folder.dart';
import 'package:mini_todo/ui/todo_list/todo_list_screen.dart';

import '../../data/repository.dart';
import '../../entity/folder.dart';
import '../../entity/todo.dart';

class TodoDetailedScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailedScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder<Todo?>(
        stream: context.read<Repository>().streamTodo(todo.id),
        initialData: todo,
        builder: (context, snapshot) {
          final todo = snapshot.data;

          if (todo == null) {
            WidgetsBinding.instance?.addPostFrameCallback((_) => Navigator.of(context).pop());
            return const SizedBox.shrink();
          }

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AppBar(todo: todo),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    BlocBuilder<FoldersCubit, List<Folder>>(
                      builder: (context, folders) {
                        final folder =
                            folders.byId(todo.folderId) ?? Folder(id: null, title: S.of(context).common__inbox);
                        return IconTheme.merge(
                          data: IconThemeData(
                            color: folder.color ?? Theme.of(context).primaryColor,
                          ),
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.subtitle1!,
                            child: ListItem(
                              icon: folder.id == null
                                  ? const Icon(Icons.inbox_outlined)
                                  : const Icon(Icons.folder_outlined),
                              title: Text(folder.title),
                              onTap: () async {
                                final folder = await showSelectFolderDialog(context: context);
                                if(folder != null) {
                                  context.read<Repository>().changeTodoFolder(todo.id, folder.id);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 1,
                      indent: 64,
                    ),
                    NowStyle(
                      date: todo.date,
                      time: todo.time,
                      textStyle: Theme.of(context).textTheme.subtitle1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListItem(
                            icon: const Icon(Icons.today),
                            title: todo.date != null ? DateTextWidget(date: todo.date!) : const Text('Без даты'),
                            onTap: () async {
                              final date = await showDateSelector(
                                context: context,
                                selectedDate: todo.date,
                              );
                              if (date != null) {
                                context.read<Repository>().setDate(todo.id, date);
                              }
                            },
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
                    InkWell(
                      onTap: () async {
                        showDeleteTodoDialog(context: context, todo: todo);
                      },
                      hoverColor: Theme.of(context).errorColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SizedBox(
                          height: 56,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Удалить',
                                style:
                                    Theme.of(context).textTheme.subtitle1?.apply(color: Theme.of(context).errorColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
    return Material(
      elevation: 1,
      child: SafeArea(
        bottom: false,
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

Future<void> showDeleteTodoDialog({
  required BuildContext context,
  required Todo todo,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).delete_todo__title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(text: S.of(context).delete_todo__content),
                  TextSpan(text: todo.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).delete_todo__caution,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).common__no),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
            onPressed: () async {
              await context.read<Repository>().delete(todo.id);
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).common__yes),
          ),
        ],
      ),
    );
