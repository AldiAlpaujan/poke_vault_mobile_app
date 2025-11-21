import 'package:json_annotation/json_annotation.dart';

part 'create_product_req.g.dart';

@JsonSerializable()
class CreateProductReq {
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'stock')
  final int stock;
  @JsonKey(name: 'group')
  final String group;
  @JsonKey(name: 'price')
  final double price;

  CreateProductReq({
    required this.productName,
    required this.categoryId,
    required this.stock,
    required this.group,
    required this.price,
  });

  factory CreateProductReq.fromJson(Map<String, dynamic> json) =>
      _$CreateProductReqFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductReqToJson(this);
}
