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

class KeyboardHideAction extends StatefulWidget {
  final Widget child;
  final VoidCallback? onStartHide;
  final VoidCallback? onEndHide;

  const KeyboardHideAction({
    Key? key,
    required this.child,
    this.onStartHide,
    this.onEndHide,
  }) : super(key: key);

  @override
  State<KeyboardHideAction> createState() => _KeyboardHideActionState();
}

class _KeyboardHideActionState extends State<KeyboardHideAction> {
  double _prev = 0;
  bool _actionWasDone = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    final curr = mediaQuery.viewInsets.bottom;
    if (_prev > 0 && curr < _prev && !_actionWasDone) {
      widget.onStartHide?.call();
      _actionWasDone = true;
    }
    if(_prev > 0 && curr == 0) {
      widget.onEndHide?.call();
    }
    _prev = curr;
    if (_prev == 0) {
      _actionWasDone = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
