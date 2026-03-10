// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonRes _$PokemonResFromJson(Map<String, dynamic> json) => PokemonRes()
  ..message = json['message'] as String?
  ..code = (json['code'] as num?)?.toInt()
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PokemonResToJson(PokemonRes instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };

Pokemon _$PokemonFromJson(Map<String, dynamic> json) =>
    Pokemon(name: json['name'] as String?, url: json['url'] as String?);

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
};
