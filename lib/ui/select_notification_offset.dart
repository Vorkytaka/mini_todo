import 'package:flutter/material.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/utils/tuple.dart';

Future<Duration?> showNotificationOffsetSelector({
  required BuildContext context,
  Duration? selectedOffset,
}) {
  return showDialog<Duration?>(
    context: context,
    builder: (context) {
      return NotificationOffsetSelector(selectedOffset: selectedOffset);
    },
  );
}

class NotificationOffsetSelector extends StatefulWidget {
  final Duration? selectedOffset;

  const NotificationOffsetSelector({
    Key? key,
    this.selectedOffset,
  }) : super(key: key);

  @override
  State<NotificationOffsetSelector> createState() => _NotificationOffsetSelectorState();
}

class _NotificationOffsetSelectorState extends State<NotificationOffsetSelector> {
  late Duration? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedOffset;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    final actionsWidget = Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 8,
        overflowAlignment: OverflowBarAlignment.end,
        overflowDirection: VerticalDirection.down,
        overflowSpacing: 0,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(s.common__cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_selected ?? const Duration(minutes: -1));
            },
            child: Text(s.common__confirm),
          ),
        ],
      ),
    );

    final _defaultOffsets = <Pair<Duration?, String>>[
      Pair(null, s.select_notification_offset__no_notification),
      Pair(Duration.zero, s.select_notification_offset__in_time),
      Pair(const Duration(minutes: 30), s.select_notification_offset__30_mins),
      Pair(const Duration(hours: 1), s.select_notification_offset__1_hour),
      Pair(const Duration(days: 1), s.select_notification_offset__1_day),
    ];

    return SimpleDialog(
      title: Text(s.select_notification_offset__title),
      children: [
        for (final offset in _defaultOffsets)
          RadioListTile<Duration?>(
            value: offset.first,
            groupValue: _selected,
            title: Text(offset.second),
            onChanged: _onChanged,
          ),
        actionsWidget,
      ],
    );
  }

  void _onChanged(Duration? duration) {
    setState(() {
      _selected = duration;
    });
  }
}
