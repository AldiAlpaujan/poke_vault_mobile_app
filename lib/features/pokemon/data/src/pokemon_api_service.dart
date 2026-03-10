import 'package:dio/dio.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/request/get_pokemon_list_req.dart';
import 'package:poke_vault_mobile_app/features/pokemon/domain/models/response/pokemon_res.dart';
import 'package:retrofit/retrofit.dart';
import 'package:poke_vault_mobile_app/shared/constants/apis.dart';

part 'pokemon_api_service.g.dart';

@RestApi()
abstract class PokemonApiService {
  factory PokemonApiService(Dio dio) = _PokemonApiService;

  @GET(Apis.getPokemonList)
  Future<HttpResponse<PokemonRes>> getPokemonList(
    @Queries() GetPokemonListReq request,
  );
}
