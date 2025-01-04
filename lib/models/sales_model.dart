import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inv_management_app/models/item_model.dart';
import 'package:inv_management_app/models/sales_product.dart';

part 'sales_model.freezed.dart';
part 'sales_model.g.dart';


@unfreezed
class SalesModel with _$SalesModel {
  factory SalesModel({
    required String? sales_date,
    required String? sales_id,
    required double? total_amount,
    required List <SalesProduct>? sales_item,


  }) = _SalesModel;

  factory SalesModel.fromJson(Map<String, dynamic> json) =>
      _$SalesModelFromJson(json);
}
