import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/config/bases/base_usecase.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/request/get_pokemon_list_req.dart';

class GetPokemonListUc
    extends UseCase<DataState<PokemonRes>, GetPokemonListReq?> {
  final PokemonRepository pokemonRepository;
  GetPokemonListUc(this.pokemonRepository);

  @override
  Future<DataState<PokemonRes>> call({GetPokemonListReq? request}) {
    return pokemonRepository.getPokemonList(request!);
  }
}
