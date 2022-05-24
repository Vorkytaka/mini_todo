import 'package:flutter/material.dart';

class GradientBody extends StatelessWidget {
  final Color color;
  final Widget child;

  const GradientBody({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                Colors.grey.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
