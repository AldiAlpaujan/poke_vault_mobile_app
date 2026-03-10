import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/config/bases/base_usecase.dart';
import 'package:poke_vault_mobile_app/features/products/domain/models/request/product_req.dart';
import 'package:poke_vault_mobile_app/features/products/domain/models/response/product_res.dart';
import 'package:poke_vault_mobile_app/features/products/domain/repositories/products_repository.dart';

class GetProductsUc extends UseCase<DataState<ProductRes>, ProductReq> {
  final ProductsRepository productsRepository;
  GetProductsUc(this.productsRepository);

  @override
  Future<DataState<ProductRes>> call({ProductReq? request}) {
    return productsRepository.getProducts(request!);
  }
}
