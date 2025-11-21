import 'package:json_annotation/json_annotation.dart';

part 'update_product_req.g.dart';

@JsonSerializable()
class UpdateProductReq {
  @JsonKey(name: 'id')
  final int id;
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

  UpdateProductReq({
    required this.id,
    required this.productName,
    required this.categoryId,
    required this.stock,
    required this.group,
    required this.price,
  });

  factory UpdateProductReq.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductReqFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProductReqToJson(this);
}
