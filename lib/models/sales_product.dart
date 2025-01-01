import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_product.freezed.dart';
part 'sales_product.g.dart';


@unfreezed
class SalesProduct with _$SalesProduct {
  factory SalesProduct({
    required int? id,
    required String? barcode,
    required String? product_name,
    required int? quantity,
    required double? cost_price,
    required double? selling_price,
    required String? measurement,
    required String? year,

  }) = _SalesProduct;

  factory SalesProduct.fromJson(Map<String, dynamic> json) =>
      _$SalesProductFromJson(json);
}
