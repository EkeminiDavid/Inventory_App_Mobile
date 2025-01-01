import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inv_management_app/features/productList_dir/provider/product_list_controller.dart';
import 'package:inv_management_app/features/sale_dir/view/sales_screen.dart';
import 'package:inv_management_app/models/cart_item.dart';
import 'package:inv_management_app/models/sales_model.dart';
import 'package:provider/provider.dart';

import '../../../components/universal/toast_widget.dart';
import '../../../db/db_helper.dart';
import '../../../models/item_model.dart';
import '../../../models/product_model.dart';
import '../../../network/network_client.dart';

class SalesProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<ItemModel> products = [];
  List<CartItem> cartItems = [];
  List<SalesModel> items = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> detailListx = [];
  NetworkService networkService = NetworkService();

  // final Map<int, int> cart = {}; // Product ID -> Quantity

  ItemModel product = ItemModel(
      id: 0,
      barcode: "0",
      product_name: "product_name",
      quantity: "",
      cost_price: 0,
      selling_price: 0,
      measurement: "",
      year: "");

  CartItem mCartItem = CartItem(
      product_quantity: 0,
      product: ItemModel(
          id: 0,
          barcode: "",
          product_name: "",
          quantity: "0",
          cost_price: 0,
          selling_price: 0,
          measurement: "",
          year: ""));

  List<ItemModel> _originalProductList = [];

  List<ItemModel> _filteredProductList = [];

  List<ItemModel> get productList => _filteredProductList;

/*  SalesProvider() {
    loadProducts();
  }*/
  TextEditingController searchController = TextEditingController();

  Future<void> loadProducts(BuildContext context) async {
    products = Provider.of<ProductListProvider>(context, listen: false).items;
    initializeProducts(products);

    notifyListeners();
  }

  void addQuantity(CartItem item) {
    // cart[productId] = (cart[productId] ?? 0) + 1;
    notifyListeners();
  }

  void subtractQuantity(CartItem item) {
    /*  if (cart[productId] != null && cart[productId]! > 0) {
      cart[productId] = cart[productId]! - 1;
      if (cart[productId] == 0) {
        cart.remove(productId);
      }
      notifyListeners();
    }*/
  }

  double calculateTotal() {
    double total = 0.0;
    int quant = 0;

    for (mCartItem in cartItems) {
      quant = mCartItem.product_quantity ?? 0;
      total += ((mCartItem.product?.selling_price ?? 0.0) * quant);
      log("This quant New  ${mCartItem.product?.selling_price ?? 0.0 * quant}");
    }
    log("This total " + total.toString());
    return total;
  }

  // Future<void> completeSale() async {
  //   final total = calculateTotal();
  //   await dbHelper.addSale(DateTime.now(), total);
  //   cart.clear();
  //   notifyListeners();
  // }

  Future<void> completeSale(BuildContext context) async {
    for (var item in cartItems) {
      detailListx.add({
        "product_name": item.product?.product_name ?? '',
        "product_id": int.parse('${item.product?.id ?? ''}'),
        "quantity": int.parse('${item.product_quantity ?? ''}'),
        // "amount": int.parse('${item.product?.selling_price ?? ''}')
        "amount": (item.product?.selling_price ?? 0.0).toInt(),
      });
    }

    Map<String, dynamic> map = {
      "total_amount": calculateTotal(),
      "sales_item": detailListx,
    };

    log(map.toString());

    // Insert the sale
    log("About to Insert");

    if (cartItems.isEmpty) {
      newErrorSnack(context, "You need to add at least one Product");
      return;
    }
    showLoader(context);
    final response = await networkService.makeSales(map);
    if (response.statusCode == 200) {
      newSuccessSnack(context, "Sales was Successful");

      cartItems.clear();
      hideLoader();
      Navigator.popUntil(context, (route) => route.isFirst);

      notifyListeners();
    } else {
      newErrorSnack(context, '${response.data.toString()}');
      hideLoader();
      return;
    }
  }

  Future<void> completeSale1(BuildContext context) async {
    final db = await dbHelper.database;

    for (var item in cartItems) {
      detailListx.add({
        "product_name": item.product?.product_name ?? '',
        "product_id": int.parse('${item.product?.id ?? ''}'),
        "quantity": int.parse('${item.product_quantity ?? ''}'),
        // "amount": int.parse('${item.product?.selling_price ?? ''}')
        "amount": (item.product?.selling_price ?? 0.0).toInt(),
      });
    }

    Map<String, dynamic> map = {
      "total_amount": calculateTotal(),
      "sales_item": detailListx,
    };

    log(map.toString());

    // Insert the sale
    log("About to Insert");

    if (cartItems.isEmpty) {
      newErrorSnack(context, "You need to add at least one Product");
      return;
    }

    final response = await networkService.makeSales(map);
    return;
/*    final saleId = await db.insert(
      dbHelper.entities.salesTable,
      {
        dbHelper.entities.saleDate: DateTime.now().toIso8601String(),
        dbHelper.entities.saleTotal: calculateTotal(),
      },
    );
    log("Sale was inserted");*/

/*
    // Insert sale details and update product quantities
    for (var entry in cart.entries) {
      final productId = entry.key;
      final quantitySold = entry.value;

      // Find the product
      final product = products.firstWhere((p) => p.id == productId);

      // Insert sale details
      await db.insert(
        dbHelper.entities.saleDetailsTable,
        {
          dbHelper.entities.saleDetailSaleId: saleId,
          dbHelper.entities.saleDetailProductId: productId,
          dbHelper.entities.saleDetailQuantity: quantitySold,
          dbHelper.entities.saleDetailPrice: product.selling_price,
        },
      );

      // Update the product quantity in the database
      final newQuantity = product.quantity - quantitySold;
      await db.update(
        dbHelper.entities.tableName,
        {dbHelper.entities.quantity: newQuantity},
        where: '${dbHelper.entities.productId} = ?',
        whereArgs: [productId],
      );
    }
*/

    log("Sales completed and product quantities updated");

    // Clear the cart after sale
    cartItems.clear();
    Navigator.popUntil(context, (route) => route.isFirst);
    final salesProvider =
        await Provider.of<ProductListProvider>(context, listen: false);

    // await salesProvider.fetchProducts();

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SalesProductScreen()));
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
              product.product_name!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (product.barcode != null &&
                  product.barcode!.toLowerCase().contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  void initializeProducts(List<ItemModel> products) {
    _originalProductList = products;
    _filteredProductList = List.from(_originalProductList);
    notifyListeners();
  }

  void addToCart(CartItem cartItem, BuildContext context) {
    if (!cartItems.contains(cartItem)) {
      cartItems.add(cartItem);
    } else {
      newErrorSnack(context, "Product already Exist in Cart");
    }
  }


  Future<void> newFetchProducts(BuildContext context) async{
    showLoader(context);
    _isLoading = true;
    try{
      final products = await networkService.getSalesService();
      items = products.body ?? [];
      notifyListeners();

      // initializeItems(_items);
      // log(_items.toString());
      hideLoader();
    }catch(err){
      print('Error fetching products: $err');
      hideLoader();

    }

  }
}
