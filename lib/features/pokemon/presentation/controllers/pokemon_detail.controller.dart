import 'package:poke_vault_mobile_app/features/pokemon/domain/models/favorite_pokemon.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_detail_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/usecases/get_pokemon_detail_uc.dart';
import 'package:poke_vault_mobile_app/objectbox.g.dart';
import 'package:poke_vault_mobile_app/shared/extensions/extensions.dart';
import 'package:poke_vault_mobile_app/shared/services/object_box_service.dart';
import 'package:poke_vault_mobile_app/shared/utils/handler_api_mixin.dart';
import 'package:get/get.dart';

class PokemonDetailController extends GetxController with HandlerApiMixin {
  final args = Get.arguments as Pokemon;

  final _box = ObjectBoxService.box<FavoritePokemon>();

  final _detail = Rxn<PokemonDetail>();
  final _isFavorite = false.obs;
  final _isLoading = true.obs;
  final _isError = false.obs;

  PokemonDetail? get detail => _detail.value;
  bool get isFavorite => _isFavorite.value;
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
      onSuccess: (result) {
        _detail.value = result?.data;
        _checkFavorite(detail!.id ?? 0);
      },
      onError: (_) => _isError.value = true,
    );
  }

  void _checkFavorite(int pokemonId) {
    final queryResult = _box
        .query(FavoritePokemon_.pokemonId.equals(pokemonId))
        .build()
        .findFirst();

    _isFavorite.value = queryResult != null;
  }

  void toggleFavorite() {
    final p = detail;
    if (p == null) return;

    final existing = _box
        .query(FavoritePokemon_.pokemonId.equals(p.id ?? 0))
        .build()
        .findFirst();

    if (existing != null) {
      _box.remove(existing.id);
    } else {
      _box.put(FavoritePokemon(pokemonId: p.id ?? 0));
    }

    _isFavorite.value = !_isFavorite.value;
  }
}
