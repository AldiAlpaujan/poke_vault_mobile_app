import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppListError extends StatelessWidget {
  final Function() onRefresh;
  const AppListError({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.server, color: const Color(0xFF98a6ad), size: 80),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Ops, Terjadi kesalahan saat mengambil\ndata dari server",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppTheme.capColor),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text(
              "Muat Ulang",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
