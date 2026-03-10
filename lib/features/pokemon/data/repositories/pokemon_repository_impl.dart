import 'package:poke_vault_mobile_app/config/bases/base_api_repository.dart';
import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_vault_mobile_app/features/pokemon/data/src/pokemon_api_service.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/request/get_pokemon_list_req.dart';

class PokemonRepositoryImpl extends ApiRepository implements PokemonRepository {
  final PokemonApiService pokemonApiService;
  PokemonRepositoryImpl(this.pokemonApiService);

  @override
  Future<DataState<PokemonRes>> getPokemonList(GetPokemonListReq request) {
    return getStateOf(request: () => pokemonApiService.getPokemonList(request));
  }
}
