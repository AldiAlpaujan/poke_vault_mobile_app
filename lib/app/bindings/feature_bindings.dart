import 'package:get/get_instance/get_instance.dart';
import 'package:poke_vault_mobile_app/app/bindings/feature_bindings/pokemon_binding.dart';

class FeatureBindings extends Bindings {
  @override
  void dependencies() {
    PokemonBinding().dependencies();
  }
}
