// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_lookup_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryLookupReq _$ProductCategoryLookupReqFromJson(
  Map<String, dynamic> json,
) => ProductCategoryLookupReq(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  search: json['search'] as String?,
);

Map<String, dynamic> _$ProductCategoryLookupReqToJson(
  ProductCategoryLookupReq instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'search': instance.search,
};
