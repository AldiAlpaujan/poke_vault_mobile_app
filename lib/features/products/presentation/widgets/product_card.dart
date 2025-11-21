import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/features/common/widget/app_card_list.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:flutter_project_template/features/products/presentation/controllers/products.controller.dart';
import 'package:flutter_project_template/shared/utils/formatter_mixin.dart';
import 'package:flutter_project_template/shared/utils/widget_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class ProductCard extends StatelessWidget with FormatterMixin {
  final Product item;
  final bool isLast;
  const ProductCard({super.key, required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProductsController>();
    return Obx(
      () => AppCardList(
        isLast: isLast,
        child: Row(
          spacing: 14,
          children: [
            if (ctrl.editMode)
              SizedBox(
                width: 14,
                height: 14,
                child: Obx(
                  () => Checkbox(
                    activeColor: AppTheme.primaryColor,
                    value: ctrl.itemIsSelected(item.id),
                    onChanged: (v) => ctrl.setSelectedItem(item.id),
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
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName),
                Text(
                  'Stok : ${item.stock}',
                  style: TextStyle(fontSize: 12, color: AppTheme.capColor),
                ),
              ],
            ).expand,
            Text(moneyFormatter(item.price)),
          ],
        ),
      ).onTap(() => ctrl.onCardTap(item)),
    );
  }
}
