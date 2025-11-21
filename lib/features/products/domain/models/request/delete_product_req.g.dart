// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_product_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteProductReq _$DeleteProductReqFromJson(Map<String, dynamic> json) =>
    DeleteProductReq(
      ids: (json['ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$DeleteProductReqToJson(DeleteProductReq instance) =>
    <String, dynamic>{'ids': instance.ids};
