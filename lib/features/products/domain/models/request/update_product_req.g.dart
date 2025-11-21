// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_product_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProductReq _$UpdateProductReqFromJson(Map<String, dynamic> json) =>
    UpdateProductReq(
      id: (json['id'] as num).toInt(),
      productName: json['product_name'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      stock: (json['stock'] as num).toInt(),
      group: json['group'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$UpdateProductReqToJson(UpdateProductReq instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'category_id': instance.categoryId,
      'stock': instance.stock,
      'group': instance.group,
      'price': instance.price,
    };
