import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mini_todo/constants.dart';
import 'package:mini_todo/dependencies.dart';
import 'package:mini_todo/ui/folder/folder_list_screen.dart';

import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OuterDependencies(
      child: MaterialApp(
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
          appBarTheme: const AppBarTheme(
            elevation: 1,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(borderRadius: borderRadiusLarge),
            elevation: 3,
            highlightElevation: 0,
          ),
          checkboxTheme: const CheckboxThemeData(
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        builder: (context, child) {
          assert(child != null);
          return InnerDependencies(
            child: child!,
          );
        },
        home: const FolderListScreen(),
      ),
    );
  }
}
