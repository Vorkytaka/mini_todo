import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mini_todo/current_time_widget.dart';
import 'package:mini_todo/dependencies.dart';
import 'package:mini_todo/entity/todo.dart';
import 'package:mini_todo/ui/new_todo.dart';
import 'package:mini_todo/utils/datetime.dart';

import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              showNewTodoDialog(context: context);
            },
            child: const Icon(Icons.add),
          );
        }),
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(
                child: Center(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Text(
                        'Входящие',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final int itemIndex = i ~/ 2;

                      if (i.isEven) {
                        return TodoItemWidget(
                          todo: Todo(
                            id: itemIndex,
                            title: 'Task $itemIndex',
                            completed: false,
                            date: DateTime(2022, 04, 28),
                            time: 60 + 10 + itemIndex,
                          ),
                        );
                      }

                      // divider
                      return const SizedBox(height: 2);
                    },
                    childCount: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  const TodoItemWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // todo: line through when completed
    final Widget titleWidget = AnimatedDefaultTextStyle(
      style: theme.textTheme.subtitle1!,
      duration: kThemeChangeDuration,
      child: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    Widget? datetimeWidget;
    if (todo.date != null) {
      datetimeWidget = _TodoItemDatetime(todo: todo);
    }

    final Widget checkbox = Checkbox(
      value: todo.completed,
      onChanged: (_) {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
    );

    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

    return SizedBox(
      height: 56,
      child: Material(
        color: Colors.grey.shade100,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () {},
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      titleWidget,
                      if (datetimeWidget != null) ...[
                        const SizedBox(height: 2),
                        datetimeWidget,
                      ],
                    ],
                  ),
                ),
                checkbox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoItemDatetime extends StatelessWidget {
  final Todo todo;

  const _TodoItemDatetime({
    Key? key,
    required this.todo,
  }) : super(key: key);

  TextStyle _textStyle(ThemeData theme, DateTime now) {
    final DateTime todoTime = todo.datetime!;
    final TextStyle textStyle = theme.textTheme.caption!;
    final Color? color;
    if (now.isBefore(todoTime)) {
      if (now.between(todoTime) > 7) {
        color = theme.hintColor;
      } else {
        color = theme.primaryColor;
      }
    } else {
      color = theme.errorColor;
    }
    return textStyle.copyWith(color: color);
  }

  // todo: inactive date when more than 7 days
  // todo: active date when less then 7 days
  // todo: error date when date is before
  @override
  Widget build(BuildContext context) {
    assert(todo.date != null);
    final now = CurrentTime.of(context);

    String str = '${todo.date}';
    if (todo.time != null) {
      str = '$str, ${todo.time}';
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
