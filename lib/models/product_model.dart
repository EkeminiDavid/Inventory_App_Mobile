class Product {
  final int? id;
  final String product_name;
  final double selling_price;
  final String product_barcode;
  final double cost_price;
  final String unit_of_measurement;
  final int quantity;




  Product({
    this.id,
    required this.product_name,
    required this.selling_price,
    required this.product_barcode,
    required this.cost_price,
    required this.unit_of_measurement,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': product_name,
      'selling_price': selling_price,
      'product_barcode': product_barcode,
      'unit_of_measurement': unit_of_measurement,
      'cost_price': cost_price,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      product_name: map['product_name'],
      selling_price: map['selling_price'],
      product_barcode: map['product_barcode'],
      unit_of_measurement: map['unit_of_measurement'],
      cost_price: map['cost_price'],
      quantity: map['quantity'],
    );
  }
}