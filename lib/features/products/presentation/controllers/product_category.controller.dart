import 'package:poke_vault_mobile_app/config/bases/base_api_pagination.dart';
import 'package:poke_vault_mobile_app/features/products/domain/models/request/product_category_lookup_req.dart';
import 'package:poke_vault_mobile_app/features/products/domain/models/response/product_category_lookup_res.dart';
import 'package:poke_vault_mobile_app/features/products/domain/usecases/product_category_lookup_uc.dart';
import 'package:get/get.dart';

class ProductCategoryController extends ApiPagination<ProductCategory> {
  @override
  Future<void> getData({bool isLoad = false, String? keyword}) async {
    final uc = Get.find<ProductCategoryLookupUc>().call;
    await runRequest(
      (req) => uc(request: ProductCategoryLookupReq.fromParent(req)),
      isLoad,
      keyword,
    );
  }

  @override
  Future<void> loadData() async {
    await getData(isLoad: true);
  }

  @override
  Future<void> refreshData() {
    return getData();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
