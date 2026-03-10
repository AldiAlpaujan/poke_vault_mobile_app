import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/config/bases/base_api_pagination.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/request/get_pokemon_list_req.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/usecases/get_pokemon_list_uc.dart';
import 'package:poke_vault_mobile_app/shared/extensions/extensions.dart';

class PokemonListController extends ApiPagination<Pokemon> {
  @override
  Future<void> getData({bool isLoad = false, String? keyword}) async {
    await runRequest(
      (req) => Get.find<GetPokemonListUc>()(
        request: GetPokemonListReq.fromParent(req),
      ),
      isLoad,
      keyword,
    );
  }

  @override
  Future<void> refreshData() {
    return getData();
  }

  @override
  Future<void> loadData() async {
    await getData(isLoad: true);
  }

  @override
  bool matchSearch(Pokemon item, String keyword) =>
      item.name.val().toLowerCase().contains(keyword.toLowerCase());

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
