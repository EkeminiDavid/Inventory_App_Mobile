// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      product_quantity: (json['product_quantity'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : ItemModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'product_quantity': instance.product_quantity,
      'product': instance.product,
    };
