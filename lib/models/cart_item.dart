import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inv_management_app/models/item_model.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';


@unfreezed
class CartItem with _$CartItem {
  factory CartItem({
    required int? product_quantity,
    required ItemModel? product,


  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
