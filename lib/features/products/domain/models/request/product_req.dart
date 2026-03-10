import 'package:poke_vault_mobile_app/features/common/domain/models/request/pagination_req.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_req.g.dart';

@JsonSerializable()
class ProductReq extends PaginationReq {
  ProductReq({super.page, super.limit, super.search});

  factory ProductReq.fromParent(PaginationReq parent) {
    return ProductReq(
      page: parent.page,
      limit: parent.limit,
      search: parent.search,
    );
  }

  factory ProductReq.fromJson(Map<String, dynamic> json) =>
      _$ProductReqFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReqToJson(this);
}
