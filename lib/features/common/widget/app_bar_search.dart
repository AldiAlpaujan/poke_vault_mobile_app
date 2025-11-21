import 'package:flutter_project_template/features/common/widget/app_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/features/common/widget/app_back_button.dart';
import 'package:flutter_project_template/shared/constants/gen/assets.gen.dart';
import 'package:flutter_project_template/shared/utils/function.dart';
import 'package:get/get.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? hintText;
  final bool withLeading;
  final bool centerTitle;
  final Function(String)? onChanged;
  final List<Widget>? actions;
  const AppBarSearch({
    super.key,
    this.actions,
    required this.title,
    this.withLeading = true,
    this.onChanged,
    this.hintText = 'Pencarian...',
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  final controller = TextEditingController();
  final searchMode = false.obs;

  void close() {
    if (widget.onChanged != null) {
      widget.onChanged!('');
      controller.clear();
    }
  }

  void onSearch() {
    searchMode.value = !searchMode.value;
    if (!searchMode.value) close();
  }

  void onLeadingTap() {
    if (searchMode.value) {
      searchMode.value = false;
      close();
    } else {
      Get.back();
    }
  }

  Future<void> onWillPop() async {
    if (searchMode.value) {
      searchMode.value = false;
      close();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !searchMode.value,
        onPopInvokedWithResult: (_, _) => onWillPop(),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppTheme.shadowColor,
                offset: Offset(-1, 0),
              ),
            ],
          ),
          child: AppBar(
            elevation: 0,
            titleSpacing: widget.withLeading ? 0 : null,
            centerTitle: widget.centerTitle,
            backgroundColor: Colors.white,
            leading: widget.withLeading
                ? AppBackButton(onPressed: onLeadingTap, color: Colors.black)
                : null,
            title: searchMode.value ? formSearch() : Text(widget.title),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              if (widget.onChanged != null)
                IconButton(
                  onPressed: onSearch,
                  icon: searchMode.value
                      ? Text(
                          String.fromCharCode(Icons.close.codePoint),
                          style: TextStyle(
                            inherit: false,
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: Icons.close.fontFamily,
                            package: Icons.close.fontPackage,
                          ),
                        )
                      : AppSvgIcon(svg: Assets.svg.searchNormal, size: 18),
                ),
              ...widget.actions ?? [],
            ],
          ),
        ),
      ),
    );
  }

  Widget formSearch() {
    return TextFormField(
      autofocus: true,
      controller: controller,
      onChanged: (v) {
        if (widget.onChanged != null) {
          Func.searchListener(v, (result) async => {widget.onChanged!(result)});
        }
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: const TextStyle(fontSize: 14),
        hintText: widget.hintText,
      ),
    );
  }
}
