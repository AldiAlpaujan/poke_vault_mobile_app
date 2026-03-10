import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_back_button.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final String title;
  final List<Widget>? actions;
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 0),
        ),
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: showLeading ? null : 0,
        leading: showLeading
            ? const AppBackButton(color: Colors.black)
            : const SizedBox(),
        title: Text(title),
        actions: actions,
        titleTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
