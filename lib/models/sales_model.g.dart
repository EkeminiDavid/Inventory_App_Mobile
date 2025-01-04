// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesModelImpl _$$SalesModelImplFromJson(Map<String, dynamic> json) =>
    _$SalesModelImpl(
      sales_date: json['sales_date'] as String?,
      sales_id: json['sales_id'] as String?,
      total_amount: (json['total_amount'] as num?)?.toDouble(),
      sales_item: (json['sales_item'] as List<dynamic>?)
          ?.map((e) => SalesProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesModelImplToJson(_$SalesModelImpl instance) =>
    <String, dynamic>{
      'sales_date': instance.sales_date,
      'sales_id': instance.sales_id,
      'total_amount': instance.total_amount,
      'sales_item': instance.sales_item,
    };
