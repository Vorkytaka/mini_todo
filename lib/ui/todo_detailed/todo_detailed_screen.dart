import 'package:flutter/material.dart';

class TodoDetailedScreen extends StatelessWidget {
  final int id;

  const TodoDetailedScreen({
    Key? key,
    required this.id,
  })  : assert(id > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
