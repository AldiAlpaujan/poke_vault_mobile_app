import 'package:flutter_project_template/features/common/widget/app_bar_search.dart';
import 'package:flutter_project_template/features/products/presentation/widgets/list_information.dart';
import 'package:flutter_project_template/features/products/presentation/widgets/product_card.dart';
import 'package:flutter_project_template/features/products/presentation/widgets/product_edit_action.dart';
import 'package:flutter_project_template/shared/utils/widget_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/features/common/presentation/views/app_data_list_view.dart';
import 'package:flutter_project_template/features/products/presentation/controllers/products.controller.dart';
import 'package:get/get.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: 'List Stok Barang',
        hintText: 'Pencarian...',
        centerTitle: true,
        withLeading: false,
        onChanged: (v) => controller.getData(keyword: v),
      ),
      floatingActionButton: Obx(() {
        if (controller.editMode) {
          return SizedBox();
        }
        return FloatingActionButton(
          onPressed: controller.openForm,
          child: const Icon(Icons.add),
        );
      }),
      body: Obx(
        () => Stack(
          children: [
            AppDataListView(
              noData: controller.noData,
              isError: controller.isError,
              isLoading: controller.isLoading,
              emptyData: controller.data.isEmpty,
              refreshData: () => controller.refreshData(),
              loadData: () => controller.loadData(),
              padding: const EdgeInsets.all(16),
              children: [
                ListInformation().t(2),
                ...controller.data.map((item) {
                  return ProductCard(
                    item: item,
                    isLast: item == controller.data.last,
                  );
                }),
                if (controller.editMode) SizedBox(height: 60),
              ],
            ),
            if (controller.editMode)
              Align(
                alignment: Alignment.bottomCenter,
                child: ProductEditAction(),
              ),
          ],
        ),
      ),
    );
  }
}
