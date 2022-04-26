import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mini_todo/entity/todo.dart';

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
      home: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
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
                      // final int itemIndex = i ~/ 2;

                      if (i.isEven) {
                        // return TodoItemWidget(itemIndex: itemIndex);
                      }

                      // divider
                      return const SizedBox(height: 2);
                    },
                    childCount: 0,
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
    // todo: line through when completed
    final Widget titleWidget = AnimatedDefaultTextStyle(
      style: Theme.of(context).textTheme.subtitle1!,
      duration: kThemeChangeDuration,
      child: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    // todo: inactive date when more than 7 days
    // todo: active date when less then 7 days
    // todo: error date when date is before
    Widget? datetimeWidget;
    if (todo.date != null) {
      String dateStr = '${todo.date}';
      if (todo.time != null) dateStr = '$dateStr, ${todo.time}';
      datetimeWidget = AnimatedDefaultTextStyle(
        style: Theme.of(context).textTheme.caption!,
        duration: kThemeChangeDuration,
        child: Text(
          dateStr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
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
