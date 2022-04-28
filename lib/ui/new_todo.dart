import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_todo/data/repository.dart';

import '../entity/todo.dart';
import '../utils/tuple.dart';

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
  String? title;
  DateTime? date;
  int? time;

  @override
  Widget build(BuildContext context) {
    final Widget titleField = TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Задача...',
      ),
      autofocus: true,
      textInputAction: TextInputAction.done,
      maxLines: null,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      initialValue: '',
      validator: (title) {
        if (title == null || title.isEmpty) {
          return 'Required';
        }

        return null;
      },
      onSaved: (title) {
        this.title = title;
      },
    );

    final Widget datetimeField = _DatetimeFormField(
      onSaved: (datetime) {
        if (datetime != null) {
          date = datetime.value1;
          time = datetime.value2;
        }
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

              final todo = Todo(
                id: -1,
                title: title!,
                completed: false,
                date: date,
                time: time,
              );

              context.read<Repository>().create(todo);
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
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );

    return Padding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    Expanded(
                      child: Wrap(
                        children: [
                          datetimeField,
                          const SizedBox(width: 8),
                          const _IconButton(
                            icon: Icon(Icons.inbox),
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

final DateFormat formatter = DateFormat.yMd();

class _DatetimeFormField extends FormField<Pair<DateTime, int?>?> {
  _DatetimeFormField({
    Pair<DateTime, int?>? initialValue,
    FormFieldSetter<Pair<DateTime, int?>?>? onSaved,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (FormFieldState<Pair<DateTime, int?>?> field) {
            String? str;
            if (field.value != null) {
              str = formatter.format(field.value!.value1);
              if (field.value!.value2 != null) {
                str = '$str, ${field.value!.value2}';
              }
            }
            return _IconButton(
              onTap: () async {
                final data = await _showDateTimePicker(context: field.context);
                if (data != null) {
                  field.didChange(data);
                }
              },
              icon: const Icon(Icons.today),
              text: str != null ? Text(str) : null,
            );
          },
        );
}

Future<Pair<DateTime, int?>?> _showDateTimePicker({required BuildContext context}) async {
  return showDialog(
    context: context,
    builder: (context) => const _DateTimePicker(),
  );
}

class _DateTimePicker extends StatefulWidget {
  const _DateTimePicker({Key? key}) : super(key: key);

  @override
  State<_DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<_DateTimePicker> {
  DateTime date = DateUtils.dateOnly(DateTime.now());
  int? time;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                onPressed: () {
                  date = DateUtils.dateOnly(DateTime.now());
                  setState(() {});
                },
                label: Text('Сегодня'),
              ),
              ActionChip(
                onPressed: () {
                  date = DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)));
                  setState(() {});
                },
                label: Text('Завтра'),
              ),
            ],
          ),
          CalendarDatePicker(
            initialDate: date,
            firstDate: DateTime(1994, 04, 20),
            lastDate: DateTime(2200, 04, 20),
            currentDate: DateTime.now(),
            onDateChanged: (d) {
              date = d;
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time_outlined),
            title: time == null ? const Text('Время') : Text('${time! ~/ 60}:${time! % 60}'),
            onTap: () async {
              final initialTime = DateUtils.isSameDay(DateTime.now(), date)
                  ? TimeOfDay.fromDateTime(DateTime.now())
                  : const TimeOfDay(hour: 12, minute: 0);
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: initialTime,
              );

              if (selectedTime != null) {
                time = selectedTime.hour * 60 + selectedTime.minute;
                setState(() {});
              }
            },
            trailing: time != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      time = null;
                      setState(() {});
                    },
                  )
                : null,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(
                  Pair(date, time),
                ),
                child: Text('Принять'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
