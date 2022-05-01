import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/ui/select_date.dart';

import '../entity/todo.dart';

Future<void> showNewTodoDialog({required BuildContext context}) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) {
      return const _NewTodoDialog();
    },
  );
}

class _NewTodoDialog extends StatefulWidget {
  const _NewTodoDialog({Key? key}) : super(key: key);

  @override
  State<_NewTodoDialog> createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<_NewTodoDialog> {
  final GlobalKey<FormFieldState<DateTime?>> _dateKey = GlobalKey();

  String? title;
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final Widget titleField = TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: S.of(context).new_todo__title_hint,
      ),
      autofocus: true,
      textInputAction: TextInputAction.done,
      maxLines: null,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      initialValue: '',
      validator: (title) {
        if (title == null || title.isEmpty) {
          return S.of(context).new_todo__title_required;
        }

        return null;
      },
      onSaved: (title) {
        this.title = title;
      },
    );

    // we use builder because of Form widget above this element
    final Widget submitBtn = Builder(
      builder: (context) {
        return InkWell(
          onTap: () {
            final form = Form.of(context)!;
            if (form.validate()) {
              form.save();

              final todo = Todo.carcase(
                title: title!,
                date: date,
                time: time,
              );

              context.read<Repository>().create(todo);
              Navigator.of(context).pop();
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(4)),
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
      },
    );

    return Padding(
      padding: mediaQuery.viewInsets + mediaQuery.padding + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Material(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Form(
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
                    NowStyle(
                      date: date,
                      time: time,
                      child: Expanded(
                        child: Wrap(
                          children: [
                            _DateFormField(
                              key: _dateKey,
                              onSaved: (date) {
                                this.date = date;
                              },
                              onChanged: (date) {
                                this.date = date;
                                setState(() {});
                              },
                            ),
                            const SizedBox(width: 8),
                            if (date != null)
                              _TimeFormField(
                                onSaved: (time) {
                                  this.time = time;
                                },
                                onChanged: (time) {
                                  this.time = time;
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
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
}

class _IconButton extends StatelessWidget {
  final Widget icon;
  final Widget? text;
  final VoidCallback? onTap;

  const _IconButton({
    Key? key,
    required this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (text != null) ...[
              const SizedBox(width: 4),
              text!,
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
            return _IconButton(
              onTap: () async {
                final date = await showDateSelector(
                  context: field.context,
                  selectedDate: field.value,
                );
                if (date != null) {
                  field.didChange(date);
                  onChanged?.call(date);
                }
              },
              icon: const Icon(Icons.today),
              text: field.value != null ? DateTextWidget(date: field.value!) : null,
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
            return _IconButton(
              onTap: () async {
                final time = await showTimePicker(
                  context: field.context,
                  initialTime: field.value ?? const TimeOfDay(hour: 12, minute: 00),
                );
                if (time != null) {
                  field.didChange(time);
                  onChanged?.call(time);
                }
              },
              icon: Icon(
                Icons.access_time,
                color: field.value == null ? Theme.of(field.context).hintColor : null,
              ),
              text: field.value != null ? Text(field.value!.format(field.context)) : null,
            );
          },
        );
}
