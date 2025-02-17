// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      barcode: json['barcode'] as String?,
      product_name: json['product_name'] as String?,
      quantity: json['quantity'] as String?,
      cost_price: (json['cost_price'] as num?)?.toDouble(),
      customer_rating: (json['customer_rating'] as num?)?.toDouble(),
      selling_price: (json['selling_price'] as num?)?.toDouble(),
      measurement: json['measurement'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barcode': instance.barcode,
      'product_name': instance.product_name,
      'quantity': instance.quantity,
      'cost_price': instance.cost_price,
      'customer_rating': instance.customer_rating,
      'selling_price': instance.selling_price,
      'measurement': instance.measurement,
      'year': instance.year,
    };
