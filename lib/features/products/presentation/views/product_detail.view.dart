import 'package:flutter_project_template/config/theme/theme.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:flutter_project_template/features/products/presentation/controllers/products.controller.dart';
import 'package:flutter_project_template/shared/utils/formatter_mixin.dart';
import 'package:flutter_project_template/shared/utils/widget_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatefulWidget {
  final Product item;
  const ProductDetailView({super.key, required this.item});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with FormatterMixin {
  final controller = Get.find<ProductsController>();

  final _discountPrice = 0.0.obs;
  final _total = 0.0.obs;

  double get discountPrice => _discountPrice.value;
  double get total => _total.value;

  final discount = 20;

  @override
  void initState() {
    _discountPrice.value = widget.item.price * discount / 100;
    _total.value = widget.item.price - discountPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 6,
          decoration: BoxDecoration(
            color: Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(10),
          ),
        ).b(12),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              keyValueItem('Nama Barang', widget.item.productName),
              keyValueItem('Kategori', widget.item.categoryName),
              keyValueItem('Kelompok', widget.item.group),
              keyValueItem(
                'Stok',
                widget.item.stock.toString(),
                withBorder: false,
              ),
            ],
          ),
        ).b(12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
          decoration: BoxDecoration(
            color: Color(0xFFF1F4F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Harga',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ).expand,
                    Text(
                      moneyFormatter(widget.item.price),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF68778D),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Diskon (20%)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ).expand,
                    Text(
                      moneyFormatter(discountPrice),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF68778D),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ).expand,
                    Text(
                      moneyFormatter(total),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF68778D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).b(16),
        Row(
          spacing: 12,
          children: [
            TextButton(
              onPressed: () => controller.deleteProducts([
                widget.item.id,
              ], onSuccess: Get.back),
              style: TextButton.styleFrom(
                overlayColor: Colors.red,
                side: BorderSide(width: 1.2, color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Hapus Barang", style: TextStyle(color: Colors.red)),
            ).expand,
            ElevatedButton(
              onPressed: () => controller.openForm(item: widget.item),
              child: Text("Edit Barang"),
            ).expand,
          ],
        ),
      ],
    ).all(12);
  }

  Widget keyValueItem(String key, String value, {bool withBorder = true}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        border: withBorder
            ? Border(bottom: BorderSide(color: AppTheme.borderColor, width: .8))
            : null,
      ),
      child: Row(
        children: [
          Text(key, style: TextStyle(fontWeight: FontWeight.w600)).expand,
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF68778D),
            ),
          ),
        ],
      ),
    );
  }
}
