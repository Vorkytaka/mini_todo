import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return CurrentTime(
      child: widget.child,
      now: DateTime.now(),
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

  DateTime get datetime {
    if (time == null) {
      return date;
    }

    return date.add(Duration(hours: time!.hour, minutes: time!.minute));
  }

  TextStyle _textStyle(ThemeData theme, DateTime now) {
    final DateTime dt = datetime;
    final TextStyle textStyle = theme.textTheme.caption!;
    final Color? color;
    if (now.isBefore(dt)) {
      if (now.between(dt) > 7) {
        color = theme.hintColor;
      } else {
        color = theme.primaryColor;
      }
    } else {
      color = theme.errorColor;
    }
    return textStyle.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    final now = CurrentTime.of(context);

    String str = dateFormatter.format(date);
    if (time != null) {
      str = '$str, ${time!.format(context)}';
    }

    return AnimatedDefaultTextStyle(
      style: _textStyle(Theme.of(context), now),
      duration: kThemeChangeDuration,
      child: Text(
        str,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
