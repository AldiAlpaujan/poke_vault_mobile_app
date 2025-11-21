// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductReq _$CreateProductReqFromJson(Map<String, dynamic> json) =>
    CreateProductReq(
      productName: json['product_name'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      stock: (json['stock'] as num).toInt(),
      group: json['group'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateProductReqToJson(CreateProductReq instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'category_id': instance.categoryId,
      'stock': instance.stock,
      'group': instance.group,
      'price': instance.price,
    };
