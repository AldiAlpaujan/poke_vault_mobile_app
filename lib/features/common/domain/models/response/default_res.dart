import 'package:flutter_project_template/config/bases/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_res.g.dart';

@JsonSerializable()
class DefaultRes extends BaseResponse {
  DefaultRes() : super();

  factory DefaultRes.fromJson(Map<String, dynamic> json) =>
      _$DefaultResFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultResToJson(this);
}
