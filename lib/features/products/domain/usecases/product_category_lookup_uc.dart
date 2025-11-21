import 'package:flutter_project_template/config/bases/base_data_state.dart';
import 'package:flutter_project_template/config/bases/base_usecase.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_category_lookup_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_category_lookup_res.dart';
import 'package:flutter_project_template/features/products/domain/repositories/products_repository.dart';

class ProductCategoryLookupUc
    extends
        UseCase<DataState<ProductCategoryLookupRes>, ProductCategoryLookupReq> {
  final ProductsRepository productsRepository;
  ProductCategoryLookupUc(this.productsRepository);

  @override
  Future<DataState<ProductCategoryLookupRes>> call({
    ProductCategoryLookupReq? request,
  }) {
    return productsRepository.productCategoryLookup(request!);
  }
}
