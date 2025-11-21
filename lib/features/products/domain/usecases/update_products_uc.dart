import 'package:flutter_project_template/config/bases/base_data_state.dart';
import 'package:flutter_project_template/config/bases/base_usecase.dart';
import 'package:flutter_project_template/features/common/domain/models/response/default_res.dart';
import 'package:flutter_project_template/features/products/domain/models/request/update_product_req.dart';
import 'package:flutter_project_template/features/products/domain/repositories/products_repository.dart';

class UpdateProductsUc
    extends UseCase<DataState<DefaultRes>, UpdateProductReq> {
  final ProductsRepository productsRepository;
  UpdateProductsUc(this.productsRepository);

  @override
  Future<DataState<DefaultRes>> call({UpdateProductReq? request}) {
    return productsRepository.updateproducts(request!);
  }
}
