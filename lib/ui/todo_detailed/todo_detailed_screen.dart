import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/domain/folders/folders_cubit.dart';
import 'package:mini_todo/entity/subtodo.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/list_item.dart';
import 'package:mini_todo/ui/select_date.dart';
import 'package:mini_todo/ui/select_folder.dart';

import '../../data/repository.dart';
import '../../entity/folder.dart';
import '../../entity/todo.dart';
import '../keyboard.dart';
import '../todo_checkbox.dart';

class TodoDetailedScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailedScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardUnfocus(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: StreamBuilder<Todo?>(
          stream: context.read<Repository>().streamTodo(todo.id),
          initialData: todo,
          builder: (context, snapshot) {
            final theme = Theme.of(context);
            final now = CurrentTime.of(context);
            final todo = snapshot.data;

            if (todo == null) {
              WidgetsBinding.instance?.addPostFrameCallback((_) => Navigator.of(context).pop());
              return const SizedBox.shrink();
            }

            final folderPicker = BlocBuilder<FoldersCubit, List<Folder>>(
              builder: (context, folders) {
                final folder = folders.byId(todo.folderId) ?? Folder(id: null, title: S.of(context).common__inbox);
                return IconTheme.merge(
                  data: IconThemeData(
                    color: folder.color ?? theme.primaryColor,
                  ),
                  child: DefaultTextStyle(
                    style: theme.textTheme.titleMedium!,
                    child: ListItem(
                      icon: folder.id == null ? const Icon(kDefaultInboxIcon) : const Icon(kDefaultFolderIcon),
                      title: Text(folder.title),
                      onTap: () async {
                        final folder = await showSelectFolderDialog(context: context);
                        if (folder != null) {
                          context.read<Repository>().changeTodoFolder(todo.id, folder.id);
                        }
                      },
                    ),
                  ),
                );
              },
            );

            Widget? dateDismiss;
            if (todo.date != null) {
              dateDismiss = SizedBox(
                width: 24,
                height: 24,
                child: InkResponse(
                  onTap: () => context.read<Repository>().removeDate(todo.id),
                  radius: 24,
                  child: Icon(
                    Icons.clear,
                    color: theme.hintColor,
                    size: 16,
                  ),
                ),
              );
            }
            final datePickerColor =
                todo.date == null ? theme.hintColor : colorRelativeToDate(theme, now, todo.date, todo.time);
            final datePicker = ListItem(
              icon: const Icon(Icons.today),
              title: todo.date != null
                  ? DateTextWidget(date: todo.date!)
                  : Text(S.of(context).todo_detailed_screen__no_date),
              titleColor: datePickerColor,
              iconColor: datePickerColor,
              onTap: () async {
                final date = await showDateSelector(
                  context: context,
                  selectedDate: todo.date,
                );
                if (date != null) {
                  context.read<Repository>().setDate(todo.id, date);
                }
              },
              trailing: dateDismiss,
            );

            Widget? timeDismiss;
            if (todo.time != null) {
              timeDismiss = SizedBox(
                width: 24,
                height: 24,
                child: InkResponse(
                  onTap: () => context.read<Repository>().removeTime(todo.id),
                  radius: 24,
                  child: Icon(
                    Icons.clear,
                    color: theme.hintColor,
                    size: 16,
                  ),
                ),
              );
            }
            final timePickerColor =
                todo.time == null ? theme.hintColor : colorRelativeToDate(theme, now, todo.date, todo.time);
            Widget timePicker = ListItem(
              icon: const Icon(Icons.access_time_outlined),
              title: todo.time != null
                  ? Text(todo.time!.format(context))
                  : Text(S.of(context).todo_detailed_screen__no_time),
              titleColor: timePickerColor,
              iconColor: timePickerColor,
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: todo.time ?? const TimeOfDay(hour: 12, minute: 00),
                );
                if (time != null) {
                  context.read<Repository>().setTime(todo.id, time);
                }
              },
              trailing: timeDismiss,
            );
            timePicker = AnimatedCrossFade(
              firstChild: timePicker,
              secondChild: const SizedBox(),
              crossFadeState: todo.date == null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
              sizeCurve: Curves.easeInOut,
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeIn,
            );

            final deleteItem = ListItem(
              icon: const Icon(Icons.delete),
              title: Text(S.of(context).todo_detailed_screen__delete),
              titleColor: theme.errorColor,
              iconColor: theme.errorColor,
              onTap: () async => showDeleteTodoDialog(context: context, todo: todo),
            );

            const divider = Divider(
              height: 1,
              indent: 56,
            );

            final noteField = TextFormField(
              initialValue: todo.note,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.edit_outlined),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 24 + 16 + 16,
                  minHeight: 48,
                ),
                hintText: S.of(context).todo_detailed_screen__note_hint,
                hintMaxLines: 1,
              ),
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (note) {
                context.read<Repository>().setNote(todo.id, note);
              },
            );

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
                      folderPicker,
                      divider,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          datePicker,
                          timePicker,
                        ],
                      ),
                      divider,
                      _SubtodoList(todo: todo),
                      divider,
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 56,
                        ),
                        child: Center(
                          child: noteField,
                        ),
                      ),
                      divider,
                      deleteItem,
                    ],
                  ),
                ),
              ],
            );
          },
        ),
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
              const SizedBox(width: 4),
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
        title: Text(S.of(context).delete_todo_dialog__title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(text: S.of(context).delete_todo_dialog__content),
                  TextSpan(text: todo.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).delete_todo_dialog__caution,
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

class _SubtodoList extends StatelessWidget {
  final Todo todo;

  const _SubtodoList({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<Subtodo>>(
      stream: context.read<Repository>().streamSubtodoByTodo(todo.id),
      initialData: const [],
      builder: (context, snapshot) {
        final subtodos = snapshot.data!;
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            for (int i = 0; i < subtodos.length; i++)
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 56),
                child: Center(
                  child: TextFormField(
                    key: ValueKey(subtodos[i].id),
                    initialValue: subtodos[i].title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Checkbox(
                        tristate: false,
                        value: subtodos[i].completed,
                        onChanged: (completed) =>
                            context.read<Repository>().changeSubtodoCompleted(subtodos[i].id, completed!),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 24 + 16 + 16,
                        minHeight: 48,
                      ),
                      hintText: 'Подзадача',
                      hintMaxLines: 1,
                      suffixIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: InkResponse(
                          onTap: () => context.read<Repository>().deleteSubtodo(subtodos[i].id),
                          radius: 24,
                          child: Icon(
                            Icons.clear,
                            color: theme.errorColor,
                            size: 16,
                          ),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 24 + 16 + 16,
                        minHeight: 48,
                      ),
                      counterText: '',
                    ),
                    minLines: 1,
                    maxLines: null,
                    maxLength: kSubtodoTitleMaxLength,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (title) => context.read<Repository>().changeSubtodoTitle(subtodos[i].id, title),
                  ),
                ),
              ),
            ListItem(
              titleColor: theme.hintColor,
              iconColor: theme.hintColor,
              icon: const Icon(Icons.add),
              title: Text('Добавить подзадачу'),
              onTap: () => context.read<Repository>().createSubtodoForTodo(todo.id),
            ),
          ],
        );
      },
    );
  }
}
