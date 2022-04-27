import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_todo/data/repository.dart';

import 'current_time_widget.dart';

class InnerDependencies extends StatelessWidget {
  final Widget child;

  const InnerDependencies({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurrentTimeUpdater(
      duration: const Duration(seconds: 30),
      child: RepositoryProvider<Repository>(
        create: (context) => TestRepository(),
        child: child,
      ),
    );
  }
}
