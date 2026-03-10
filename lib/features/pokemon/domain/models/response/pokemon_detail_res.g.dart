// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailRes _$PokemonDetailResFromJson(Map<String, dynamic> json) =>
    PokemonDetailRes()
      ..message = json['message'] as String?
      ..code = (json['code'] as num?)?.toInt()
      ..data = json['data'] == null
          ? null
          : PokemonDetail.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$PokemonDetailResToJson(PokemonDetailRes instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };

PokemonDetail _$PokemonDetailFromJson(Map<String, dynamic> json) =>
    PokemonDetail(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => PokemonTypeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((e) => PokemonStatSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((e) => PokemonAbilitySlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonDetailToJson(PokemonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'stats': instance.stats,
      'abilities': instance.abilities,
    };

PokemonTypeSlot _$PokemonTypeSlotFromJson(Map<String, dynamic> json) =>
    PokemonTypeSlot(
      type: json['type'] == null
          ? null
          : PokemonType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeSlotToJson(PokemonTypeSlot instance) =>
    <String, dynamic>{'type': instance.type};

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) =>
    PokemonType(name: json['name'] as String?);

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{'name': instance.name};

PokemonStatSlot _$PokemonStatSlotFromJson(Map<String, dynamic> json) =>
    PokemonStatSlot(
      baseStat: (json['base_stat'] as num?)?.toInt(),
      stat: json['stat'] == null
          ? null
          : PokemonStat.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonStatSlotToJson(PokemonStatSlot instance) =>
    <String, dynamic>{'base_stat': instance.baseStat, 'stat': instance.stat};

PokemonStat _$PokemonStatFromJson(Map<String, dynamic> json) =>
    PokemonStat(name: json['name'] as String?);

Map<String, dynamic> _$PokemonStatToJson(PokemonStat instance) =>
    <String, dynamic>{'name': instance.name};

PokemonAbilitySlot _$PokemonAbilitySlotFromJson(Map<String, dynamic> json) =>
    PokemonAbilitySlot(
      ability: json['ability'] == null
          ? null
          : PokemonAbility.fromJson(json['ability'] as Map<String, dynamic>),
      isHidden: json['is_hidden'] as bool?,
    );

Map<String, dynamic> _$PokemonAbilitySlotToJson(PokemonAbilitySlot instance) =>
    <String, dynamic>{
      'ability': instance.ability,
      'is_hidden': instance.isHidden,
    };

PokemonAbility _$PokemonAbilityFromJson(Map<String, dynamic> json) =>
    PokemonAbility(name: json['name'] as String?);

Map<String, dynamic> _$PokemonAbilityToJson(PokemonAbility instance) =>
    <String, dynamic>{'name': instance.name};
