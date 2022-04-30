import 'package:flutter/material.dart';
import 'package:mini_todo/generated/l10n.dart';

Future<DateTime?> showDateSelector({
  required BuildContext context,
  DateTime? selectedDate,
}) =>
    showDialog(
      context: context,
      builder: (context) => _DateSelector(
        selectedDate: selectedDate,
      ),
    );

class _DateSelector extends StatefulWidget {
  final DateTime? selectedDate;

  const _DateSelector({
    Key? key,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<_DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<_DateSelector> {
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              if (DateUtils.isSameDay(_selected, DateTime.now()))
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(S.of(context).common_today),
                )
              else
                ActionChip(
                  label: Text(S.of(context).common_today),
                  onPressed: () => setState(() {
                    _selected = DateTime.now();
                  }),
                ),
              if (DateUtils.isSameDay(_selected, DateTime.now().add(const Duration(days: 1))))
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(S.of(context).common_tomorrow),
                )
              else
                ActionChip(
                  label: Text(S.of(context).common_tomorrow),
                  onPressed: () => setState(() {
                    _selected = DateTime.now().add(const Duration(days: 1));
                  }),
                ),
            ],
          ),
          CalendarDatePicker(
            initialDate: _selected,
            firstDate: DateTime(1994, 04, 20),
            lastDate: DateTime(2194, 04, 20),
            onDateChanged: (selected) => setState(() {
              _selected = selected;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(S.of(context).common__cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 16),
                TextButton(
                  child: Text(S.of(context).common__confirm),
                  onPressed: () => Navigator.of(context).pop(_selected),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}