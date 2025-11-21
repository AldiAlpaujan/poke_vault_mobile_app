// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReq _$ProductReqFromJson(Map<String, dynamic> json) => ProductReq(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  search: json['search'] as String?,
);

Map<String, dynamic> _$ProductReqToJson(ProductReq instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'search': instance.search,
    };
