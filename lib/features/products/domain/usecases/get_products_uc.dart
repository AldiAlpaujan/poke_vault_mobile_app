import 'package:flutter_project_template/config/bases/base_data_state.dart';
import 'package:flutter_project_template/config/bases/base_usecase.dart';
import 'package:flutter_project_template/features/products/domain/models/request/product_req.dart';
import 'package:flutter_project_template/features/products/domain/models/response/product_res.dart';
import 'package:flutter_project_template/features/products/domain/repositories/products_repository.dart';

class GetProductsUc extends UseCase<DataState<ProductRes>, ProductReq> {
  final ProductsRepository productsRepository;
  GetProductsUc(this.productsRepository);

  @override
  Future<DataState<ProductRes>> call({ProductReq? request}) {
    return productsRepository.getProducts(request!);
  }
}
