import 'package:flutter/material.dart';

import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).app_name,
      home: const SizedBox(),
    );
  }
}
