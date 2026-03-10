import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/request/get_pokemon_list_req.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';

abstract class PokemonRepository {
  Future<DataState<PokemonRes>> getPokemonList(GetPokemonListReq request);
}
