import 'package:json_annotation/json_annotation.dart';
import 'package:poke_vault_mobile_app/features/common/domain/models/request/pagination_req.dart';

part 'get_pokemon_list_req.g.dart';

@JsonSerializable()
class GetPokemonListReq extends PaginationReq {
  GetPokemonListReq({super.page, super.offset, super.limit, super.search});

  factory GetPokemonListReq.fromParent(PaginationReq parent) {
    return GetPokemonListReq(
      page: parent.page,
      limit: parent.limit,
      search: parent.search,
      offset: parent.offset,
    );
  }

  factory GetPokemonListReq.fromJson(Map<String, dynamic> json) =>
      _$GetPokemonListReqFromJson(json);
  Map<String, dynamic> toJson() => _$GetPokemonListReqToJson(this);
}
