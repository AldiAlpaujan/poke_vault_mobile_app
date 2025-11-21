import 'package:flutter_project_template/config/bases/base_data_state.dart';
import 'package:flutter_project_template/features/common/domain/models/response/default_res.dart';
import 'package:flutter_project_template/features/products/domain/models/request/create_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/delete_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_category_lookup_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/request/update_product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_category_lookup_res.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';

abstract class ProductsRepository {
  Future<DataState<ProductRes>> getProducts(ProductReq request);

  Future<DataState<DefaultRes>> createProducts(CreateProductReq request);

  Future<DataState<DefaultRes>> updateproducts(UpdateProductReq request);

  Future<DataState<DefaultRes>> deleteProducts(DeleteProductReq request);

  Future<DataState<ProductCategoryLookupRes>> productCategoryLookup(
    ProductCategoryLookupReq request,
  );
}
