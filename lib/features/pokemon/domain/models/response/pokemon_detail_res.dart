import 'package:json_annotation/json_annotation.dart';
import 'package:poke_vault_mobile_app/config/bases/base_response.dart';

part 'pokemon_detail_res.g.dart';

@JsonSerializable()
class PokemonDetailRes extends BaseResponse<PokemonDetail> {
  PokemonDetailRes() : super();

  factory PokemonDetailRes.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailResFromJson(json);
}

@JsonSerializable()
class PokemonDetail {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'types')
  final List<PokemonTypeSlot>? types;

  @JsonKey(name: 'stats')
  final List<PokemonStatSlot>? stats;

  @JsonKey(name: 'abilities')
  final List<PokemonAbilitySlot>? abilities;

  PokemonDetail({this.id, this.name, this.types, this.stats, this.abilities});

  String? get officialArtwork =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

  factory PokemonDetail.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailFromJson(json);
}

@JsonSerializable()
class PokemonTypeSlot {
  @JsonKey(name: 'type')
  final PokemonType? type;

  PokemonTypeSlot({this.type});

  factory PokemonTypeSlot.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeSlotFromJson(json);
}

@JsonSerializable()
class PokemonType {
  @JsonKey(name: 'name')
  final String? name;

  PokemonType({this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);
}

@JsonSerializable()
class PokemonStatSlot {
  @JsonKey(name: 'base_stat')
  final int? baseStat;

  @JsonKey(name: 'stat')
  final PokemonStat? stat;

  PokemonStatSlot({this.baseStat, this.stat});

  factory PokemonStatSlot.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatSlotFromJson(json);
}

@JsonSerializable()
class PokemonStat {
  @JsonKey(name: 'name')
  final String? name;

  PokemonStat({this.name});

  factory PokemonStat.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatFromJson(json);
}

@JsonSerializable()
class PokemonAbilitySlot {
  @JsonKey(name: 'ability')
  final PokemonAbility? ability;

  @JsonKey(name: 'is_hidden')
  final bool? isHidden;

  PokemonAbilitySlot({this.ability, this.isHidden});

  factory PokemonAbilitySlot.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilitySlotFromJson(json);
}

@JsonSerializable()
class PokemonAbility {
  @JsonKey(name: 'name')
  final String? name;

  PokemonAbility({this.name});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);
}
