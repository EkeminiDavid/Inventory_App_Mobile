class SaleDetail {
  final int? id;
  final int saleId;
  final int productId;
  final int quantity;
  final double price;

  SaleDetail({
    this.id,
    required this.saleId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saleId': saleId,
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory SaleDetail.fromMap(Map<String, dynamic> map) {
    return SaleDetail(
      id: map['id'],
      saleId: map['saleId'],
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
