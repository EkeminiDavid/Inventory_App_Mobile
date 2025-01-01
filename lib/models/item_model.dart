import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';


@unfreezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    required int? id,
    required String? barcode,
    required String? product_name,
    required String? quantity,
    required double? cost_price,
    required double? selling_price,
    required String? measurement,
    required String? year,

  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
