import 'package:get/get.dart';
import 'package:poke_vault_mobile_app/shared/utils/main_helpers.dart';
import 'package:poke_vault_mobile_app/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_vault_mobile_app/features/pokemon/data/src/pokemon_api_service.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_list.controller.dart';
import 'package:poke_vault_mobile_app/features/pokemon/presentation/controllers/pokemon_detail.controller.dart';

class PokemonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PokemonApiService(dio), fenix: true);
    Get.lazyPut<PokemonRepository>(
      () => PokemonRepositoryImpl(Get.find<PokemonApiService>()),
      fenix: true,
    );
    // Controllers
    Get.lazyPut(() => PokemonListController(), fenix: true);
    Get.lazyPut(() => PokemonDetailController(), fenix: true);
  }
}
