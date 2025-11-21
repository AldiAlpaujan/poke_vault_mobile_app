// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_lookup_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryLookupRes _$ProductCategoryLookupResFromJson(
  Map<String, dynamic> json,
) => ProductCategoryLookupRes()
  ..message = json['message'] as String?
  ..code = (json['code'] as num?)?.toInt()
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProductCategoryLookupResToJson(
  ProductCategoryLookupRes instance,
) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
  'data': instance.data,
};

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
