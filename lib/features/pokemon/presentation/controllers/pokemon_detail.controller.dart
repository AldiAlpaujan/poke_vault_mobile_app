import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_detail_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/usecases/get_pokemon_detail_uc.dart';
import 'package:poke_vault_mobile_app/shared/extensions/extensions.dart';
import 'package:poke_vault_mobile_app/shared/utils/handler_api_mixin.dart';
import 'package:get/get.dart';

class PokemonDetailController extends GetxController with HandlerApiMixin {
  final args = Get.arguments as Pokemon;

  final _detail = Rxn<PokemonDetail>();
  final _isLoading = true.obs;
  final _isError = false.obs;

  PokemonDetail? get detail => _detail.value;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    _isError.value = false;
    _isLoading.value = true;
    final res = await Get.find<GetPokemonDetailUc>()(request: args.id.val);
    _isLoading.value = false;

    handleApiResult<PokemonDetailRes>(
      res,
      onSuccess: (result) => _detail.value = result?.data,
      onError: (_) => _isError.value = true,
    );
  }
}
