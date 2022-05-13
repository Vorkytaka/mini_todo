import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Widget? trailing;

  const ListItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.trailing,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconWidget = IconTheme.merge(
      data: IconThemeData(
        color: iconColor,
      ),
      child: icon,
    );

    final titleStyle = theme.textTheme.titleMedium!.copyWith(color: titleColor);
    final titleWidget = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: title,
    );

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                child: Center(
                  child: iconWidget,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: titleWidget,
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
