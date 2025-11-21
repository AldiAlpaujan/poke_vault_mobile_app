import 'package:flutter_project_template/config/bases/base_data_state.dart';
import 'package:flutter_project_template/config/bases/base_usecase.dart';
import 'package:flutter_project_template/features/common/domain/models/response/default_res.dart';
import 'package:flutter_project_template/features/products/domain/models/request/delete_product_req.dart';
import 'package:flutter_project_template/features/products/domain/repositories/products_repository.dart';

class DeleteProductsUc
    extends UseCase<DataState<DefaultRes>, DeleteProductReq> {
  final ProductsRepository productsRepository;
  DeleteProductsUc(this.productsRepository);

  @override
  Future<DataState<DefaultRes>> call({DeleteProductReq? request}) {
    return productsRepository.deleteProducts(request!);
  }
}
