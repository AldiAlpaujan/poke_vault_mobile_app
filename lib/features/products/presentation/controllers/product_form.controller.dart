import 'package:flutter_project_template/app/routes/pages.dart';
import 'package:flutter_project_template/features/products/domain/models/request/create_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/update_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_category_lookup_res.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:flutter_project_template/features/products/domain/usecases/create_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/update_products_uc.dart';
import 'package:flutter_project_template/shared/utils/formatter_mixin.dart';
import 'package:flutter_project_template/shared/utils/handler_api_mixin.dart';
import 'package:flutter_project_template/shared/utils/main_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFormController extends GetxController
    with HandlerApiMixin, FormatterMixin {
  Product? get product => Get.arguments;

  ProductCategory? category;

  double price = 0;

  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final categoryC = TextEditingController();
  final groupC = TextEditingController();
  final stockC = TextEditingController();
  final priceC = TextEditingController();

  final groups = [
    'Elektronik',
    'Pakaian',
    'Makanan & Minuman',
    'Kesehatan & Kecantikan',
    'Perabot Rumah Tangga',
    'Olahraga & Hobi',
    'Buku & Alat Tulis',
    'Mainan & Anak-anak',
    'Otomotif',
    'Perhiasan & Aksesori',
    'Pertanian',
    'Alat Musik',
    'Produk Digital',
    'Computer Accessories',
  ];

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      if (product == null) {
        createData();
      } else {
        updateData();
      }
    }
  }

  void createData() async {
    modalHelper.loading();
    final result = await Get.find<CreateProductsUc>().call(
      request: CreateProductReq(
        productName: nameC.text,
        categoryId: category!.id,
        group: groupC.text,
        stock: int.tryParse(stockC.text) ?? 0,
        price: price,
      ),
    );
    Get.back();
    handleApiResult(
      result,
      onSuccess: (v) {
        Get.back(result: true);
      },
    );
  }

  Future<void> updateData() async {
    final productId = product?.id;
    modalHelper.loading();
    final result = await Get.find<UpdateProductsUc>().call(
      request: UpdateProductReq(
        id: productId!,
        productName: nameC.text,
        categoryId: category!.id,
        group: groupC.text,
        stock: int.tryParse(stockC.text) ?? 0,
        price: price,
      ),
    );
    Get.back();
    handleApiResult(
      result,
      onSuccess: (v) {
        Get.back(result: true);
      },
    );
  }

  Future<void> pickCategory() async {
    final result = await Get.toNamed(Routes.productCategory);
    if (result != null) {
      category = result;
      categoryC.text = category!.name;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (product != null) {
      category = ProductCategory(
        id: product!.categoryId,
        name: product!.categoryName,
      );
      nameC.text = product!.productName;
      categoryC.text = product!.categoryName;
      groupC.text = groups.contains(product!.group) ? product!.group : '';
      stockC.text = product!.stock.toString();
      priceC.text = doubleFormatter(product!.price);
      price = product!.price;
    }
  }
}
