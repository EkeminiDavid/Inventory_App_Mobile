// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesProductImpl _$$SalesProductImplFromJson(Map<String, dynamic> json) =>
    _$SalesProductImpl(
      id: (json['id'] as num?)?.toInt(),
      barcode: json['barcode'] as String?,
      product_name: json['product_name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      cost_price: (json['cost_price'] as num?)?.toDouble(),
      selling_price: (json['selling_price'] as num?)?.toDouble(),
      measurement: json['measurement'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$$SalesProductImplToJson(_$SalesProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barcode': instance.barcode,
      'product_name': instance.product_name,
      'quantity': instance.quantity,
      'cost_price': instance.cost_price,
      'selling_price': instance.selling_price,
      'measurement': instance.measurement,
      'year': instance.year,
    };
