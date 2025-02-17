import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/toast_widget.dart';
import 'package:inv_management_app/models/item_model.dart';

import '../../../models/product_model.dart';
import '../../../network/network_client.dart';
import '../../../services/db_service.dart';
import '../../../utils/scanner.dart';

class ProductListProvider extends ChangeNotifier {
  List<Product> _products = [];
   List<ItemModel> _items = [];
  final TextEditingController searchController = TextEditingController();
  final NetworkService networkService;
  List<Product> _originalProductList = [];
  List<ItemModel> _originalItemList = [];

  List<Product> _filteredProductList = [];
  List<ItemModel> _filteredItemList = [];

  List<Product> get productList => _filteredProductList;
  List<ItemModel> get itemList => _filteredItemList;


  ProductListProvider(this.networkService);

  List<Product> get products => _products;
  List<ItemModel> get items => _items;



   Future<void> initMethod(BuildContext context) async {
     // fetchProducts();
    await newFetchProducts(context);

   }

   Future<void> newFetchProducts(BuildContext context) async{
     showLoader(context);
     try{
       final products = await networkService.getProductService();
       _items = products.body ?? [];
       notifyListeners();

       initializeItems(_items);
       log(_items.toString());
       hideLoader();
     }catch(err){
       print('Error fetching products: $err');
       hideLoader();

     }

   }

  // Future<void> fetchProducts() async {
  //   try {
  //     _products = await _productService.getProducts();
  //     initializeProducts(_products);
  //
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //   }
  // }


  // Future<void> deleteProduct(int? productId) async {
  //   try {
  //     await _productService.deleteProduct(productId);
  //     await fetchProducts();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error deleting product: $e');
  //   }
  // }
  //


  void initializeProducts(List<Product> products) {
    _originalProductList = products;
    _filteredProductList = List.from(_originalProductList);
    notifyListeners();
  }

  void initializeItems(List<ItemModel> items) {
    _originalItemList = items;
    _filteredItemList = List.from(_originalItemList);
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredItemList = List.from(_originalItemList);
    } else {
      _filteredItemList = _originalItemList
          .where((product) =>
      product.product_name!.toLowerCase().contains(query.toLowerCase()) ||
          (product.barcode != null &&
              product.barcode!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  Future<void> startBarcodeScan(BuildContext context) async {
    try {

      String? scannedData = await barcodeScanner(context);

      if (scannedData != '-1') {
        // Display scanned data
        searchController.text = scannedData!;
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

