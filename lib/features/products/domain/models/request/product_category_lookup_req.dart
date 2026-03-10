import 'package:poke_vault_mobile_app/features/common/domain/models/request/pagination_req.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category_lookup_req.g.dart';

@JsonSerializable()
class ProductCategoryLookupReq extends PaginationReq {
  ProductCategoryLookupReq({super.page, super.limit, super.search});

  factory ProductCategoryLookupReq.fromParent(PaginationReq parent) {
    return ProductCategoryLookupReq(
      page: parent.page,
      limit: parent.limit,
      search: parent.search,
    );
  }

  factory ProductCategoryLookupReq.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryLookupReqFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryLookupReqToJson(this);
}
