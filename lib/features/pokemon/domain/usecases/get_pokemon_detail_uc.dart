import 'package:poke_vault_mobile_app/config/bases/base_data_state.dart';
import 'package:poke_vault_mobile_app/config/bases/base_usecase.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_detail_res.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetailUc extends UseCase<DataState<PokemonDetailRes>, int> {
  final PokemonRepository pokemonRepository;
  GetPokemonDetailUc(this.pokemonRepository);

  @override
  Future<DataState<PokemonDetailRes>> call({int? request}) {
    return pokemonRepository.getPokemonDetail(request!);
  }
}
