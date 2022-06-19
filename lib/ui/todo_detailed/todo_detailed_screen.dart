import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/data/subtodo_repository.dart';
import 'package:mini_todo/domain/use_case.dart';
import 'package:mini_todo/entity/subtodo.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/list_item.dart';
import 'package:mini_todo/ui/todo_detailed/todo_detailted_cubit.dart';

import '../../current_time_widget.dart';
import '../../data/todo_repository.dart';
import '../../domain/folders/folders_cubit.dart';
import '../../entity/folder.dart';
import '../../entity/todo.dart';
import '../../utils/tuple.dart';
import '../common/keyboard.dart';
import '../select_date.dart';
import '../select_folder.dart';
import '../select_notification_offset.dart';
import '../todo_checkbox.dart';

class TodoDetailedScreen extends StatelessWidget {
  final int todoId;

  const TodoDetailedScreen({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardUnfocus(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: BlocProvider<TodoDetailedCubit>(
          create: (context) => TodoDetailedCubit(
            todoId: todoId,
            todoRepository: context.read(),
          ),
          child: BlocConsumer<TodoDetailedCubit, TodoDetailedState>(
            listener: (context, state) {
              if (state.initialized && state.todo == null) {
                Navigator.of(context).pop();
              }
            },
            buildWhen: (prev, curr) => curr.hasTodo,
            builder: (context, state) {
              final theme = Theme.of(context);
              final now = CurrentTime.of(context);
              final todo = state.todo;

              if (todo == null) {
                return const SizedBox.shrink();
              }

              final folderPicker = BlocBuilder<FoldersCubit, List<Pair<Folder, int>>>(
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
                            context.read<TodoRepository>().updateFolder(todo.id, folder.id);
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
                    onTap: () async => await deleteTodoDate(context, todo.id),
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
                    await updateTodoDate(context, todo.id, date);
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
                    onTap: () async => await deleteTodoTime(context, todo.id),
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
                    await updateTodoTime(context, todo.id, time);
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

              final Color? notificationOffsetColor = todo.notificationOffset == null
                  ? theme.hintColor
                  : colorRelativeToDate(theme, now, todo.date, todo.time, todo.notificationOffset);
              Widget notificationOffsetPicker = ListItem(
                onTap: () async {
                  final offset = await showNotificationOffsetSelector(
                    context: context,
                    selectedOffset: todo.notificationOffset,
                  );

                  if (offset != null) {
                    if (offset.isNegative) {
                      await deleteTodoNotificationOffset(context, todo.id);
                    } else {
                      await updateTodoNotificationOffset(context, todo.id, offset);
                    }
                  }
                },
                iconColor: notificationOffsetColor,
                titleColor: notificationOffsetColor,
                icon: todo.notificationOffset != null
                    ? const Icon(Icons.notifications_active_outlined)
                    : const Icon(Icons.notifications_off_outlined),
                title: Text(todo.notificationOffset != null
                    ? todo.notificationOffset!.format(context)
                    : S.of(context).todo_detailed_screen__notification_without),
              );
              notificationOffsetPicker = AnimatedCrossFade(
                firstChild: notificationOffsetPicker,
                secondChild: const SizedBox(),
                crossFadeState: todo.time == null ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
                  context.read<TodoRepository>().updateNote(todo.id, note);
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
                            notificationOffsetPicker,
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
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Todo todo;

  const _AppBar({
    Key? key,
    required this.todo,
  }) : super(key: key);

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
                child: TextFormField(
                  initialValue: todo.title,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (title) {
                    context.read<TodoRepository>().setTitle(todo.id, title);
                  },
                ),
              ),
              TodoCheckbox(todo: todo),
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
              await deleteTodo(context, todo.id);
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).common__yes),
          ),
        ],
      ),
    );

class _SubtodoList extends StatefulWidget {
  final Todo todo;

  const _SubtodoList({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<_SubtodoList> createState() => _SubtodoListState();
}

class _SubtodoListState extends State<_SubtodoList> {
  late final AnimatedListController controller;
  List<Subtodo>? _subtodos;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    controller = AnimatedListController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription ??= context.read<SubtodoRepository>().streamByTodo(widget.todo.id).listen((event) {
      _subtodos = event;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        if (_subtodos != null)
          AutomaticAnimatedListView<Subtodo>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            list: _subtodos!,
            listController: controller,
            itemBuilder: (context, item, data) {
              if (data.measuring) return const SizedBox(height: 56);
              return _SubtodoItemWidget(subtodo: item);
            },
            comparator: AnimatedListDiffListComparator(
              sameItem: (a, b) => a.id == b.id,
              sameContent: (a, b) => a == b,
            ),
            morphDuration: Duration.zero,
            animator: const DefaultAnimatedListAnimator(
              dismissIncomingDuration: Duration(milliseconds: 100),
              resizeDuration: Duration(milliseconds: 250),
            ),
          ),
        _AddSubtodoElement(todo: widget.todo),
      ],
    );
  }
}

class _AddSubtodoElement extends StatefulWidget {
  final Todo todo;

  const _AddSubtodoElement({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<_AddSubtodoElement> createState() => _AddSubtodoElementState();
}

class _AddSubtodoElementState extends State<_AddSubtodoElement> {
  bool _inCreateState = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _inCreateState = false;
          // ???
          if (_controller.text.isNotEmpty) {
            context.read<SubtodoRepository>().createForTodo(widget.todo.id, _controller.text);
          }
          _controller.clear();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: _inCreateState
          ? TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 24 + 16 + 16,
                    minHeight: 56,
                  ),
                  hintText: S.of(context).todo_detailed_screen__add_subtodo,
                  hintMaxLines: 1,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.done),
                    onPressed: () {
                      _focusNode.unfocus();
                    },
                  )),
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              focusNode: _focusNode,
            )
          : ListItem(
              titleColor: theme.hintColor,
              iconColor: theme.hintColor,
              icon: const Icon(Icons.add),
              title: Text(S.of(context).todo_detailed_screen__add_subtodo),
              onTap: () {
                setState(() {
                  _inCreateState = true;
                });
                _focusNode.requestFocus();
              },
            ),
    );
  }
}

class _SubtodoItemWidget extends StatelessWidget {
  final Subtodo subtodo;

  const _SubtodoItemWidget({
    Key? key,
    required this.subtodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 56,
      child: Center(
        child: TextFormField(
          key: ValueKey(subtodo.id),
          initialValue: subtodo.title,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Checkbox(
              tristate: false,
              value: subtodo.completed,
              onChanged: (completed) => context.read<SubtodoRepository>().changeCompleted(subtodo.id, completed!),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 24 + 16 + 16,
              minHeight: 48,
            ),
            hintText: S.of(context).todo_detailed_screen__subtodo_hint,
            hintMaxLines: 1,
            suffixIcon: SizedBox(
              width: 24,
              height: 24,
              child: InkResponse(
                onTap: () => context.read<SubtodoRepository>().delete(subtodo.id),
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
          style: TextStyle(
            decoration: subtodo.completed ? TextDecoration.lineThrough : null,
          ),
          minLines: 1,
          maxLines: 1,
          maxLength: kSubtodoTitleMaxLength,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (title) => context.read<SubtodoRepository>().changeTitle(subtodo.id, title),
        ),
      ),
    );
  }
}

extension DurationIntl on Duration {
  String format(BuildContext context) {
    final s = S.of(context);

    if (inMinutes == 0) {
      return s.todo_detailed_screen__notification_in_time;
    }

    if (inDays != 0) {
      return s.todo_detailed_screen__notification_days(inDays);
    }

    if (inHours != 0) {
      return s.todo_detailed_screen__notification_hours(inHours);
    }

    return s.todo_detailed_screen__notification_minutes(inMinutes);
  }
}
