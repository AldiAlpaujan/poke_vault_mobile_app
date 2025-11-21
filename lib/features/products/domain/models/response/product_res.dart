import 'package:flutter_project_template/config/bases/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_res.g.dart';

@JsonSerializable()
class ProductRes extends BaseResponse<List<Product>> {
  ProductRes() : super();

  factory ProductRes.fromJson(Map<String, dynamic> json) =>
      _$ProductResFromJson(json);
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'stock')
  final int stock;
  @JsonKey(name: 'group')
  final String group;
  @JsonKey(name: 'price')
  final double price;

  Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.productName,
    required this.stock,
    required this.group,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
