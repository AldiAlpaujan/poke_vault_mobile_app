import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/features/products/presentation/controllers/products.controller.dart';
import 'package:flutter_project_template/shared/utils/widget_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductEditAction extends StatelessWidget {
  const ProductEditAction({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProductsController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: AppTheme.shadowColor,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 14,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: Obx(
                  () => Checkbox(
                    activeColor: AppTheme.primaryColor,
                    value: ctrl.isSelectAll,
                    onChanged: (_) => ctrl.selectAllToggle(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(
                      width: 1.4,
                      color: AppTheme.bodyColor,
                    ),
                  ),
                ),
              ),
              Text('Pilih Semua').expand,
            ],
          ).onTap(ctrl.selectAllToggle).expand,

          ElevatedButton(
            onPressed: ctrl.bulkDelete,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              foregroundColor: WidgetStateProperty.all(Colors.red),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              side: WidgetStateProperty.all(
                BorderSide(width: 1.2, color: Colors.red),
              ),
              elevation: WidgetStatePropertyAll(0),
            ),
            child: Text("Hapus Barang", style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
