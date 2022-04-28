import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/generated/l10n.dart';

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
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
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
                id: 0,
                title: title!,
                completed: false,
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

class _DatetimeFormField extends FormField<Pair<DateTime, TimeOfDay?>?> {
  _DatetimeFormField({
    Pair<DateTime, TimeOfDay?>? initialValue,
    FormFieldSetter<Pair<DateTime, TimeOfDay?>?>? onSaved,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          builder: (FormFieldState<Pair<DateTime, TimeOfDay?>?> field) {
            Widget? datetimeWidget;
            if (field.value != null) {
              datetimeWidget = DatetimeOnNowWidget(
                date: field.value!.value1,
                time: field.value?.value2,
              );
            }
            return _IconButton(
              onTap: () async {
                final data = await _showDateTimePicker(
                  context: field.context,
                  date: field.value?.value1,
                  time: field.value?.value2,
                );
                if (data != null) {
                  field.didChange(data);
                }
              },
              icon: const Icon(Icons.today),
              text: datetimeWidget,
            );
          },
        );
}

Future<Pair<DateTime, TimeOfDay?>?> _showDateTimePicker({
  required BuildContext context,
  DateTime? date,
  TimeOfDay? time,
}) async {
  return showDialog(
    context: context,
    builder: (context) => _DateTimePicker(
      date: date,
      time: time,
    ),
  );
}

class _DateTimePicker extends StatefulWidget {
  final DateTime? date;
  final TimeOfDay? time;

  const _DateTimePicker({
    Key? key,
    this.date,
    this.time,
  }) : super(key: key);

  @override
  State<_DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<_DateTimePicker> {
  late DateTime date;
  TimeOfDay? time;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateUtils.dateOnly(DateTime.now());
    time = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: SingleChildScrollView(
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
                  label: Text(S.of(context).datetime_dialog__today),
                ),
                ActionChip(
                  onPressed: () {
                    date = DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)));
                    setState(() {});
                  },
                  label: Text(S.of(context).datetime_dialog__tomorrow),
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
              dense: true,
              leading: const Icon(Icons.access_time_outlined),
              title: time == null ? Text(S.of(context).datetime_dialog__time) : Text(time!.format(context)),
              onTap: () async {
                final initialTime = DateUtils.isSameDay(DateTime.now(), date)
                    ? TimeOfDay.fromDateTime(DateTime.now())
                    : const TimeOfDay(hour: 12, minute: 0);
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: initialTime,
                );

                if (selectedTime != null) {
                  time = selectedTime;
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
                  child: Text(S.of(context).common__cancel),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(
                    Pair(date, time),
                  ),
                  child: Text(S.of(context).common__confirm),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
