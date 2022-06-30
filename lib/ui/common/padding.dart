import 'package:flutter/material.dart';

class FabSliverPadding extends StatelessWidget {
  const FabSliverPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return SliverToBoxAdapter(
      child: SizedBox(height: 56 + 8 + 8 + data.viewInsets.bottom),
    );
  }
}
