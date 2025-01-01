// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewBaseResponse<T> _$NewBaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    NewBaseResponse<T>(
      status_code: (json['status_code'] as num?)?.toInt(),
      body: json['body'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NewBaseResponseToJson<T>(
  NewBaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.status_code,
      'body': instance.body,
      'message': instance.message,
    };
