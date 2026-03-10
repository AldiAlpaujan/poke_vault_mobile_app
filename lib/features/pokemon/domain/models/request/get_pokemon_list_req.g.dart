// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pokemon_list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPokemonListReq _$GetPokemonListReqFromJson(Map<String, dynamic> json) =>
    GetPokemonListReq(
      page: (json['page'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      search: json['search'] as String?,
    );

Map<String, dynamic> _$GetPokemonListReqToJson(GetPokemonListReq instance) =>
    <String, dynamic>{
      'page': instance.page,
      'offset': instance.offset,
      'limit': instance.limit,
      'search': instance.search,
    };
