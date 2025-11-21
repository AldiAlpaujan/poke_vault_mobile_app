// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultRes _$DefaultResFromJson(Map<String, dynamic> json) => DefaultRes()
  ..message = json['message'] as String?
  ..code = (json['code'] as num?)?.toInt()
  ..data = json['data'];

Map<String, dynamic> _$DefaultResToJson(DefaultRes instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
    };
