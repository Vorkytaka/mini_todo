import 'package:flutter/material.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/domain/use_case.dart';
import 'package:mini_todo/entity/folder.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/select_date.dart';
import 'package:mini_todo/ui/select_folder.dart';
import 'package:mini_todo/ui/todo_detailed/todo_detailed_screen.dart';

import '../entity/todo.dart';

Future<void> showNewTodoDialog({
  required BuildContext context,
  Folder? folder,
  DateTime? date,
}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) {
      return _NewTodoDialog(
        folder: folder,
        date: date,
      );
    },
  );
}

class _NewTodoDialog extends StatefulWidget {
  final Folder? folder;
  final DateTime? date;

  const _NewTodoDialog({
    Key? key,
    this.folder,
    this.date,
  }) : super(key: key);

  @override
  State<_NewTodoDialog> createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<_NewTodoDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormFieldState<DateTime?>> _dateKey = GlobalKey();

  String? title;
  DateTime? date;
  TimeOfDay? time;
  Folder? folder;

  @override
  void initState() {
    super.initState();
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final Widget titleField = TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: S.of(context).new_todo_dialog__title_hint,
      ),
      onFieldSubmitted: (str) {
        _submit();
      },
      autofocus: true,
      textInputAction: TextInputAction.done,
      maxLines: null,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      initialValue: '',
      validator: (title) {
        if (title == null || title.isEmpty) {
          return S.of(context).new_todo_dialog__title_required;
        }

        return null;
      },
      onSaved: (title) {
        this.title = title;
      },
    );

    // we use builder because of Form widget above this element
    final Widget submitBtn = InkWell(
      onTap: _submit,
      onLongPress: () {
        print('long');
      },
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.send,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: mediaQuery.viewInsets + mediaQuery.padding + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: Colors.grey.shade50,
        borderRadius: borderRadiusMedium,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                titleField,
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          NowStyle(
                            date: date,
                            time: time,
                            child: _DateFormField(
                              key: _dateKey,
                              initialValue: widget.date,
                              onSaved: (date) {
                                this.date = date;
                              },
                              onChanged: (date) {
                                this.date = date;
                                if (date == null) {
                                  time = null;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (date != null) ...[
                            NowStyle(
                              date: date,
                              time: time,
                              child: _TimeFormField(
                                onSaved: (time) {
                                  this.time = time;
                                },
                                onChanged: (time) {
                                  this.time = time;
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          _FolderFormField(
                            initialValue: widget.folder,
                            onSaved: (folder) {
                              this.folder = folder;
                            },
                          ),
                        ],
                      ),
                    ),
                    submitBtn,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      final todo = Todo.carcase(
        title: title!,
        date: date,
        time: time,
        folderId: folder?.id,
      );

      final todoId = await createTodo(context, todo);

      if (widget.folder == null || widget.folder?.id != folder?.id) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        final s = S.of(context);
        final navigator = Navigator.of(context, rootNavigator: true);
        Future.delayed(const Duration(milliseconds: 250), () {
          scaffoldMessenger.hideCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: RichText(
                maxLines: 2,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: todo.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: s.new_todo_dialog__snackbar_text),
                    TextSpan(
                      text: folder?.title ?? s.common__inbox,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              action: SnackBarAction(
                label: 'ОТКРЫТЬ',
                onPressed: () {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => TodoDetailedScreen(todoId: todoId),
                    ),
                  );
                },
              ),
              behavior: SnackBarBehavior.fixed,
            ),
          );
        });
      }

      Navigator.of(context).pop();
    }
  }
}

class Chip extends StatelessWidget {
  final Widget icon;
  final Widget? text;
  final VoidCallback? onTap;
  final VoidCallback? onCancelTap;

  const Chip({
    Key? key,
    required this.icon,
    this.text,
    this.onTap,
    this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (text != null) ...[
              const SizedBox(width: 8),
              text!,
            ],
            if (onCancelTap != null) ...[
              const SizedBox(width: 8),
              InkResponse(
                onTap: onCancelTap,
                radius: 18,
                child: const Icon(
                  Icons.clear,
                  size: 18,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DateFormField extends FormField<DateTime?> {
  _DateFormField({
    Key? key,
    DateTime? initialValue,
    FormFieldSetter<DateTime?>? onSaved,
    ValueChanged<DateTime?>? onChanged,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (field) {
            void setValue(DateTime? date) {
              field.didChange(date);
              onChanged?.call(date);
            }

            return Chip(
              onTap: () async {
                final date = await showDateSelector(
                  context: field.context,
                  selectedDate: field.value,
                );
                if (date != null) {
                  setValue(date);
                }
              },
              icon: const Icon(Icons.today),
              text: field.value != null ? DateTextWidget(date: field.value!) : null,
              onCancelTap: field.value != null ? () => setValue(null) : null,
            );
          },
        );
}

class _TimeFormField extends FormField<TimeOfDay?> {
  _TimeFormField({
    Key? key,
    TimeOfDay? initialValue,
    FormFieldSetter<TimeOfDay?>? onSaved,
    ValueChanged<TimeOfDay?>? onChanged,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (field) {
            void setValue(TimeOfDay? time) {
              field.didChange(time);
              onChanged?.call(time);
            }

            return Chip(
              onTap: () async {
                final time = await showTimePicker(
                  context: field.context,
                  initialTime: field.value ?? const TimeOfDay(hour: 12, minute: 00),
                );
                if (time != null) {
                  setValue(time);
                }
              },
              icon: Icon(
                Icons.access_time,
                color: field.value == null ? Theme.of(field.context).hintColor : null,
              ),
              text: field.value != null ? Text(field.value!.format(field.context)) : null,
              onCancelTap: field.value != null ? () => setValue(null) : null,
            );
          },
        );
}

class _FolderFormField extends FormField<Folder?> {
  _FolderFormField({
    Key? key,
    Folder? initialValue,
    FormFieldSetter<Folder?>? onSaved,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (field) {
            final theme = Theme.of(field.context);
            final s = S.of(field.context);
            final folder = field.value ?? Folder(id: null, title: s.common__inbox);

            return Chip(
              icon: folder.id == null
                  ? Icon(
                      kDefaultInboxIcon,
                      color: theme.primaryColor,
                    )
                  : Icon(
                      kDefaultFolderIcon,
                      color: folder.color,
                    ),
              text: DefaultTextStyle(
                style: theme.textTheme.labelMedium!,
                child: Text(folder.title),
              ),
              onTap: () async {
                final folder = await showSelectFolderDialog(context: field.context);
                if (folder != null) {
                  field.didChange(folder);
                }
              },
            );
          },
        );
}
