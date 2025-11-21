import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/theme/theme.dart';

class AppCardList extends StatelessWidget {
  final bool isLast;
  final double padding;
  final Widget child;
  const AppCardList({
    super.key,
    required this.isLast,
    required this.child,
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: padding, bottom: padding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : AppTheme.borderColor,
            width: .4,
          ),
        ),
      ),
      child: child,
    );
  }
}
