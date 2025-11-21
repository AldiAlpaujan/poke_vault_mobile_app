import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/features/common/widget/app_empty_data.dart';
import 'package:flutter_project_template/features/common/widget/app_list_error.dart';
import 'package:flutter_project_template/features/common/widget/app_loading.dart';
import 'package:flutter_project_template/features/common/widget/app_refresh.dart';

class AppDataListView extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final bool emptyData;
  final bool noData;
  final EdgeInsetsGeometry padding;
  final Future Function() refreshData;
  final Future Function()? loadData;
  final List<Widget> children;
  const AppDataListView({
    super.key,
    this.isLoading = false,
    this.isError = false,
    this.emptyData = false,
    this.noData = true,
    required this.refreshData,
    this.loadData,
    required this.children,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppTheme.padding,
      vertical: 4,
    ),
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppLoading();
    if (isError) return AppListError(onRefresh: refreshData);
    return Stack(
      children: [
        if (emptyData) const AppEmptyData(),
        AppRefresh(
          noDataToLoad: noData,
          onRefresh: refreshData,
          onLoading: loadData,
          child: ListView(padding: padding, children: children),
        ),
      ],
    );
  }
}
