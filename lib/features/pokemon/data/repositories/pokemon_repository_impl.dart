import 'package:poke_vault_mobile_app/config/bases/base_api_repository.dart';
import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_vault_mobile_app/features/pokemon/data/src/pokemon_api_service.dart';

class PokemonRepositoryImpl extends ApiRepository implements PokemonRepository {
  final PokemonApiService pokemonApiService;
  PokemonRepositoryImpl(this.pokemonApiService);
}
