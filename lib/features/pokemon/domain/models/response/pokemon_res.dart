import 'package:json_annotation/json_annotation.dart';
import 'package:poke_vault_mobile_app/config/bases/base_response.dart';

part 'pokemon_res.g.dart';

@JsonSerializable()
class PokemonRes extends BaseResponse<List<Pokemon>> {
  PokemonRes() : super();

  factory PokemonRes.fromJson(Map<String, dynamic> json) =>
      _$PokemonResFromJson(json);
}

@JsonSerializable()
class Pokemon {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'url')
  final String? url;

  Pokemon({required this.name, required this.url});

  int? get id =>
      int.tryParse((url ?? '').split('/').where((s) => s.isNotEmpty).last);

  String? get officialArtwork =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
