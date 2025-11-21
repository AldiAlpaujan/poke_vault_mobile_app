import 'package:json_annotation/json_annotation.dart';

part 'delete_product_req.g.dart';

@JsonSerializable()
class DeleteProductReq {
  @JsonKey(name: "ids")
  final List<int> ids;

  DeleteProductReq({required this.ids});

  factory DeleteProductReq.fromJson(Map<String, dynamic> json) =>
      _$DeleteProductReqFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteProductReqToJson(this);
}
