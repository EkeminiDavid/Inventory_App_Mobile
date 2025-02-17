import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/toast_widget.dart';
import 'package:inv_management_app/db/db_helper.dart';
import 'package:inv_management_app/network/network_client.dart';
import 'package:inv_management_app/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../utils/scanner.dart';
import '../../productList_dir/provider/product_list_controller.dart';

class AddProductProvider extends ChangeNotifier {
  final barcodeController = TextEditingController();
  final productNameController = TextEditingController();
  final costPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  String? selectedUnit;
  List<String> units = ['Pcs', 'Can', 'Bottle', 'Carton'];
  int quantity = 0;
  NetworkService networkService = NetworkService();

  void selectUnit(String newValue) {
    selectedUnit = newValue;
    notifyListeners();
  }

/*  final ProductService service;
  final DatabaseHelper dbHelper;*/

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

    var bodyForServer = {
      "barcode": productBarcode,
      "cost_price": costPrice,
      "measurement": unitOfMeasurement,
      "product_name": productName,
      "quantity": quantity,
      "selling_price": sellingPrice
    };
    await add(bodyForServer, context);
    // await service.addProduct(newProduct);
    await fetchProducts();
    Provider.of<ProductListProvider>(context, listen: false)
        .newFetchProducts(context);
    notifyListeners();
  }

  Future<void> add(
      Map<String, dynamic> bodyForServer, BuildContext context) async {
    showLoader(context);
    final response = await networkService.addProductService(bodyForServer);
    if (response == true) {
      hideLoader();
      if (context.mounted) {
        newSuccessSnack(context, "Product Added to Server");
      }
    } else {
      hideLoader();
      if (context.mounted) {
        newErrorSnack(
          context,
          "Product noy Added to Server",
        );
      }
    }
  }

  Future<void> fetchProducts() async {
    // _products = await service.getProducts();
    log(_products.toString());
    notifyListeners();
  }

  Future<void> addNewProduct(BuildContext context) async {
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quantity can be less than or equal to 0 ")),
      );
      return;
    }

    if (productNameController.text.toString() == "") {
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
    await addProduct(context,
        productName: productNameController.text ?? "",
        sellingPrice: double.parse(sellingPriceController.text),
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

  Future<String> startBarcodeScan(BuildContext context) async {
    try {
      String realBarcode = "";
      String? scannedData = await barcodeScanner(context);

      if (scannedData != '-1') {
        barcodeController.text = scannedData!;
        notifyListeners();
        return realBarcode;
      } else {
        return "Not Successful";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return "Not Successful";
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

  Future<void> scanBarcode(BuildContext context) async {
    String barcode = await startBarcodeScan(context);
    // barcodeController.text = barcode;
    // notifyListeners();
  }
}
