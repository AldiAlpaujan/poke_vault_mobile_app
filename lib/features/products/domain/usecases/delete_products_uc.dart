import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/config/bases/base_usecase.dart';
import 'package:poke_vault_mobile_app/features/common/domain/models/response/default_res.dart';
import 'package:poke_vault_mobile_app/features/products/domain/models/request/delete_product_req.dart';
import 'package:poke_vault_mobile_app/features/products/domain/repositories/products_repository.dart';

class DeleteProductsUc
    extends UseCase<DataState<DefaultRes>, DeleteProductReq> {
  final ProductsRepository productsRepository;
  DeleteProductsUc(this.productsRepository);

  @override
  Future<DataState<DefaultRes>> call({DeleteProductReq? request}) {
    return productsRepository.deleteProducts(request!);
  }
}
