import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final Widget? leading;

  final Widget? title;

  final Widget? subtitle;

  final Widget? trailing;

  final VoidCallback? onTap;

  final VoidCallback? onLongPress;

  final double horizontalTitleGap;

  final double minimumHeight;

  const ListCard({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.horizontalTitleGap = 16,
    this.minimumHeight = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minimumHeight),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (leading != null) leading!,
                    SizedBox(width: horizontalTitleGap),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (title != null) title!,
                        if (subtitle != null) subtitle!
                      ],
                    ),
                  ],
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
