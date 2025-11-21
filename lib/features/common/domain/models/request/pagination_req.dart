import 'package:json_annotation/json_annotation.dart';

part 'pagination_req.g.dart';

@JsonSerializable()
class PaginationReq {
  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "limit")
  int? limit;

  @JsonKey(name: "search")
  String? search;

  PaginationReq({this.page, this.limit, this.search});

  PaginationReq copyWith({String? search}) {
    return PaginationReq(
      page: page,
      limit: limit,
      search: search ?? this.search,
    );
  }

  factory PaginationReq.fromJson(Map<String, dynamic> json) =>
      _$PaginationReqFromJson(json);
}
