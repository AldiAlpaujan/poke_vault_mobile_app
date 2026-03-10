import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:poke_vault_mobile_app/shared/constants/apis.dart';

part 'pokemon_api_service.g.dart';

@RestApi()
abstract class PokemonApiService {
  factory PokemonApiService(Dio dio) = _PokemonApiService;
}
