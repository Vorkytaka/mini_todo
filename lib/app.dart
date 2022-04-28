import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/data/repository.dart';
import 'package:mini_todo/dependencies.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/new_todo.dart';
import 'package:mini_todo/ui/todo_list/todo_list_screen.dart';

import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      onGenerateTitle: (context) => S.of(context).app_name,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
      ),
      builder: (context, child) {
        assert(child != null);
        return InnerDependencies(
          child: child!,
        );
      },
      home: const TodoListScreen(),
    );
  }
}
