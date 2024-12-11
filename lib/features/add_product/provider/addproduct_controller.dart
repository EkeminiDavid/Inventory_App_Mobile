import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inv_management_app/db/db_helper.dart';
import 'package:inv_management_app/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../productList_dir/provider/product_list_controller.dart';

class AddProductProvider extends ChangeNotifier {
  final barcodeController = TextEditingController();
  final productNameController = TextEditingController();
  final costPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  String? selectedUnit;
  List<String> units = ['Pcs', 'Can', 'Bottle', 'Carton'];
  int quantity = 0;

  void selectUnit(String newValue) {
    selectedUnit = newValue;
    notifyListeners();
  }

  final ProductService service;
  final DatabaseHelper dbHelper;

  AddProductProvider({required this.service, required this.dbHelper});

  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> addProduct(
    BuildContext context, {
    required String productName,
    required double sellingPrice,
    required String productBarcode,
    required double costPrice,
    required String unitOfMeasurement,
    required int quantity,
  }) async {
    Product newProduct = Product(
      product_name: productName,
      selling_price: sellingPrice,
      product_barcode: productBarcode,
      cost_price: costPrice,
      unit_of_measurement: unitOfMeasurement,
      quantity: quantity,
    );
    await service.addProduct(newProduct);
    await fetchProducts();
    Provider.of<ProductListProvider>(context, listen: false).fetchProducts();
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _products = await service.getProducts();
    log(_products.toString());
    notifyListeners();
  }

  void addNewProduct(BuildContext context) {
    if(quantity <= 0){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quantity can be less than or equal to 0 ")),
      );
      return;
    }

    if(productNameController.text.toString() == ""){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Every Product must have a name")),
      );
      return;
    }
    log('\n'
        '${productNameController.text}\n'
        '${sellingPriceController.text}\n'
        '${barcodeController.text}\n'
        '${costPriceController.text}\n'
        '${selectedUnit ?? ''}\n'
        'Quantity is $quantity\n');
    addProduct(context,
        productName: productNameController.text ?? "",
        sellingPrice: double.parse(sellingPriceController.text)  ,
        productBarcode: barcodeController.text ?? "",
        costPrice: double.parse(costPriceController.text),
        unitOfMeasurement: selectedUnit ?? '',
        quantity: quantity);
    clearFields();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    barcodeController.dispose();
    productNameController.dispose();
    costPriceController.dispose();
    sellingPriceController.dispose();
    super.dispose();
  }

  void clearFields() {
    barcodeController.clear();
    productNameController.clear();
    costPriceController.clear();
    sellingPriceController.clear();
    selectedUnit = null;
  }

  Future<void> startBarcodeScan(BuildContext context) async {
    try {
      // Start the barcode scan
      String scannedData = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Scanner overlay color
        "Cancel", // Cancel button text
        true, // Enable flash
        ScanMode.BARCODE, // Scan mode (BARCODE or QR code)
      );

      if (scannedData != '-1') {
        // Display scanned data
        barcodeController.text = scannedData;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Scanned Data: $scannedData")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  addClicked() {
    quantity = quantity + 1;
    notifyListeners();

  }

  minusClicked() {
    quantity = quantity - 1;
    if (quantity < 0) {
      quantity = 0;
    }
    notifyListeners();
  }
}
