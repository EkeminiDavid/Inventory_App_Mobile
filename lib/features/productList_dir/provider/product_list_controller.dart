import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../models/product_model.dart';
import '../../../services/db_service.dart';

class ProductListProvider extends ChangeNotifier {
  final ProductService _productService;
  List<Product> _products = [];
  final TextEditingController searchController = TextEditingController();


  ProductListProvider(this._productService);

  List<Product> get products => _products;


   void initMethod(){
     fetchProducts();

   }

  Future<void> fetchProducts() async {
    try {
      _products = await _productService.getProducts();
      initializeProducts(_products);

      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Future<void> addProduct(Product product) async {
  //   try {
  //     await _productService.addProduct(product);
  //     await fetchProducts();
  //   } catch (e) {
  //     print('Error adding product: $e');
  //   }
  // }

  Future<void> deleteProduct(int? productId) async {
    try {
      await _productService.deleteProduct(productId);
      await fetchProducts();
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  List<Product> _originalProductList = [];

  List<Product> _filteredProductList = [];

  List<Product> get productList => _filteredProductList;


  void initializeProducts(List<Product> products) {
    _originalProductList = products;
    _filteredProductList = List.from(_originalProductList);
    notifyListeners();
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


  // Dispose the search controller when provider is disposed
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

