import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_todo/generated/l10n.dart';
import 'package:mini_todo/utils/datetime.dart';

import 'ui/formatter.dart';

class CurrentTimeUpdater extends StatefulWidget {
  final Duration duration;
  final Widget child;

  const CurrentTimeUpdater({
    Key? key,
    required this.duration,
    required this.child,
  }) : super(key: key);

  @override
  State<CurrentTimeUpdater> createState() => _CurrentTimeUpdaterState();
}

class _CurrentTimeUpdaterState extends State<CurrentTimeUpdater> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return CurrentTime(
      child: widget.child,
      now: DateTime(now.year, now.month, now.day, now.hour, now.minute),
    );
  }
}

class CurrentTime extends InheritedWidget {
  final DateTime now;

  const CurrentTime({
    Key? key,
    required Widget child,
    required this.now,
  }) : super(key: key, child: child);

  static DateTime of(BuildContext context) {
    assert(debugCheckHasCurrentTime(context));
    return context.dependOnInheritedWidgetOfExactType<CurrentTime>()!.now;
  }

  static DateTime? maybeOf(BuildContext context) {
    assert(debugCheckHasCurrentTime(context));
    return context.dependOnInheritedWidgetOfExactType<CurrentTime>()?.now;
  }

  @override
  bool updateShouldNotify(CurrentTime oldWidget) {
    return now != oldWidget.now;
  }
}

bool debugCheckHasCurrentTime(BuildContext context) {
  assert(() {
    if (context.widget is! CurrentTime && context.getElementForInheritedWidgetOfExactType<CurrentTime>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No CurrentTime widget ancestor found.'),
        ErrorDescription('${context.widget.runtimeType} widgets require a CurrentTime widget ancestor.'),
      ]);
    }
    return true;
  }());
  return true;
}

class DatetimeOnNowWidget extends StatelessWidget {
  final DateTime date;
  final TimeOfDay? time;

  const DatetimeOnNowWidget({
    Key? key,
    required this.date,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = dateFormatter.format(date);
    if (time != null) {
      str = '$str, ${time!.format(context)}';
    }

    return NowStyle(
      date: date,
      time: time,
      child: DateTextWidget(
        date: date,
        time: time,
      ),
    );
  }
}

class NowStyle extends StatelessWidget {
  final Widget child;
  final DateTime? date;
  final TimeOfDay? time;
  final TextStyle? textStyle;

  const NowStyle({
    Key? key,
    required this.child,
    this.date,
    this.time,
    this.textStyle,
  }) : super(key: key);

  Color? _color(ThemeData theme, DateTime now) {
    if (date == null) {
      return null;
    }

    if (time == null) {
      final nowDate = DateUtils.dateOnly(now);
      if (date!.isBefore(nowDate)) {
        return theme.errorColor;
      } else {
        return theme.primaryColor;
      }
    }

    final datetime = date! & time;
    if (datetime.isBefore(now)) {
      return theme.errorColor;
    } else {
      return theme.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = CurrentTime.of(context);

    final color = _color(theme, now);
    final textStyle = (this.textStyle ?? theme.textTheme.caption!).apply(color: color);

    return AnimatedDefaultTextStyle(
      style: textStyle,
      duration: kThemeChangeDuration,
      child: IconTheme.merge(
        data: IconThemeData(color: color),
        child: child,
      ),
    );
  }
}

class DateTextWidget extends StatelessWidget {
  final DateTime date;
  final TimeOfDay? time;

  const DateTextWidget({
    Key? key,
    required this.date,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = CurrentTime.of(context);

    String str;
    if (DateUtils.isSameDay(date, now)) {
      str = S.of(context).common_today;
    } else if (DateUtils.isSameDay(date, now + const Duration(days: 1))) {
      str = S.of(context).common_tomorrow;
    } else if (DateUtils.isSameDay(date, now - const Duration(days: 1))) {
      str = S.of(context).common_yesterday;
    } else {
      str = dateFormatter.format(date);
    }

    if (time != null) {
      str = '$str, ${time!.format(context)}';
    }

    return Text(str);
  }
}
