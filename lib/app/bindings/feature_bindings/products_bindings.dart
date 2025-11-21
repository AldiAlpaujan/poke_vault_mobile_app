import 'package:get/get.dart';
import 'package:flutter_project_template/shared/utils/main_helpers.dart';
import 'package:flutter_project_template/features/products/data/repositories/products_repository_impl.dart';
import 'package:flutter_project_template/features/products/data/src/products_api_service.dart';
import 'package:flutter_project_template/features/products/domain/repositories/products_repository.dart';
import 'package:flutter_project_template/features/products/domain/usecases/get_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/create_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/update_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/delete_products_uc.dart';
import 'package:flutter_project_template/features/products/domain/usecases/product_category_lookup_uc.dart';

class ProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsApiService(dio), fenix: true);
    Get.lazyPut<ProductsRepository>(
      () => ProductsRepositoryImpl(Get.find<ProductsApiService>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetProductsUc(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => CreateProductsUc(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => UpdateProductsUc(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => DeleteProductsUc(Get.find<ProductsRepository>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ProductCategoryLookupUc(Get.find<ProductsRepository>()),
      fenix: true,
    );
  }
}
