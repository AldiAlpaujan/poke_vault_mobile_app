import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:poke_vault_mobile_app/features/products/presentation/controllers/products.controller.dart';
import 'package:poke_vault_mobile_app/shared/utils/widget_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ListInformation extends StatelessWidget {
  const ListInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProductsController>();

    return Row(
      children: [
        Text(
          ctrl.editMode
              ? '${ctrl.selectedItem.length} Data dipilih'
              : '${ctrl.data.length} Data ditampilkan',
          style: TextStyle(fontSize: 12, color: AppTheme.capColor),
        ).expand,
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            ctrl.editMode ? 'Selesai' : 'Edit Data',
            style: TextStyle(fontSize: 12, color: AppTheme.primaryColor),
          ),
        ).onTap(ctrl.editModeToggle),
      ],
    );
  }
}
