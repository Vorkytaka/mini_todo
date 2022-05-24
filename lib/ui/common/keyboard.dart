import 'package:flutter/material.dart';

class KeyboardUnfocus extends StatefulWidget {
  final Widget child;

  const KeyboardUnfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<KeyboardUnfocus> createState() => _KeyboardUnfocusState();
}

class _KeyboardUnfocusState extends State<KeyboardUnfocus> {
  double _prev = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    final curr = mediaQuery.viewInsets.bottom;
    if (_prev > 0 && curr < _prev) {
      FocusScope.of(context).unfocus();
    }
    _prev = curr;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
