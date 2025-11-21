import 'package:flutter_project_template/config/bases/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category_lookup_res.g.dart';

@JsonSerializable()
class ProductCategoryLookupRes extends BaseResponse<List<ProductCategory>> {
  ProductCategoryLookupRes() : super();

  factory ProductCategoryLookupRes.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryLookupResFromJson(json);
}

@JsonSerializable()
class ProductCategory {
  final int id;
  final String name;

  ProductCategory({required this.id, required this.name});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}
