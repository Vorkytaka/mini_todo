import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final VoidCallback? onTap;

  const ListItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 16),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
