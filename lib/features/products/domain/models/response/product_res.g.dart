// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRes _$ProductResFromJson(Map<String, dynamic> json) => ProductRes()
  ..message = json['message'] as String?
  ..code = (json['code'] as num?)?.toInt()
  ..data = (json['data'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProductResToJson(ProductRes instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num).toInt(),
  categoryId: (json['category_id'] as num).toInt(),
  categoryName: json['category_name'] as String,
  productName: json['product_name'] as String,
  stock: (json['stock'] as num).toInt(),
  group: json['group'] as String,
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'product_name': instance.productName,
  'stock': instance.stock,
  'group': instance.group,
  'price': instance.price,
};
