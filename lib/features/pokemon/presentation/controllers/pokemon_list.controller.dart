import 'package:poke_vault_mobile_app/config/bases/base_api_pagination.dart';

class PokemonListController extends ApiPagination {
  @override
  Future<void> getData({bool isLoad = false, String? keyword}) async {
    // await runRequest(
    //   usecase,
    //   isLoad,
    //   keyword,
    // );
  }

  @override
  Future<void> loadData() async {
    await getData();
  }

  @override
  Future<void> refreshData() {
    return getData(isLoad: true);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
