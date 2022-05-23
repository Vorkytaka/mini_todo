import 'package:flutter/material.dart';

class ColoredThemeWrapper extends StatelessWidget {
  final Color color;
  final Widget child;

  const ColoredThemeWrapper({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        toggleableActiveColor: color,
      ),
      child: child,
    );
  }
}
