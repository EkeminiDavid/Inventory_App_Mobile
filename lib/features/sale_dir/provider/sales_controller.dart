import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inv_management_app/features/sale_dir/view/sales_screen.dart';

import '../../../db/db_helper.dart';
import '../../../models/product_model.dart';

class SalesProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Product> products = [];
  final Map<int, int> cart = {}; // Product ID -> Quantity



  List<Product> _originalProductList = [];

  List<Product> _filteredProductList = [];

  List<Product> get productList => _filteredProductList;


  SalesProvider() {
    loadProducts();
  }
  TextEditingController searchController = TextEditingController();


  Future<void> loadProducts() async {
    products = await dbHelper.getProducts();
    initializeProducts(products);

    notifyListeners();
  }

  void addToCart(int productId) {
    cart[productId] = (cart[productId] ?? 0) + 1;
    notifyListeners();
  }

  void removeFromCart(int productId) {
    if (cart[productId] != null && cart[productId]! > 0) {
      cart[productId] = cart[productId]! - 1;
      if (cart[productId] == 0) {
        cart.remove(productId);
      }
      notifyListeners();
    }
  }

  double calculateTotal() {
    double total = 0.0;
    cart.forEach((productId, quantity) {
      final product = products.firstWhere((p) => p.id == productId);
      total += product.selling_price * quantity;
    });
    return total;
  }

  // Future<void> completeSale() async {
  //   final total = calculateTotal();
  //   await dbHelper.addSale(DateTime.now(), total);
  //   cart.clear();
  //   notifyListeners();
  // }


  Future<void> completeSale(BuildContext context) async {
    final db = await dbHelper.database;

    // Insert the sale
    log("About to Insert");
    final saleId = await db.insert(
      dbHelper.entities.salesTable,
      {
        dbHelper.entities.saleDate: DateTime.now().toIso8601String(),
        dbHelper.entities.saleTotal: calculateTotal(),
      },
    );
    log("Was inserted");


    // Insert sale details
    cart.forEach((productId, quantity) async {
      final product = products.firstWhere((p) => p.id == productId);
      await db.insert(
        dbHelper.entities.saleDetailsTable,
        {
          dbHelper.entities.saleDetailSaleId: saleId,
          dbHelper.entities.saleDetailProductId: productId,
          dbHelper.entities.saleDetailQuantity: quantity,
          dbHelper.entities.saleDetailPrice: product.selling_price,
        },
      );
    });
    log("Sales Completed");

    // Clear the cart after sale
    cart.clear();
    Navigator.popUntil(context, (route) => route.isFirst);

    notifyListeners();
  }

  int quantity = 0;


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

  void gotoProductList(BuildContext context) {

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesProductScreen()));

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
        searchController.text = scannedData;
        searchProducts(scannedData);
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

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProductList = List.from(_originalProductList);
    } else {
      _filteredProductList = _originalProductList
          .where((product) =>
      product.product_name!.toLowerCase().contains(query.toLowerCase()) ||
          (product.product_barcode != null &&
              product.product_barcode!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  void initializeProducts(List<Product> products) {
    _originalProductList = products;
    _filteredProductList = List.from(_originalProductList);
    notifyListeners();
  }





}
