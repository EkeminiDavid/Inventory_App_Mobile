import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inv_management_app/features/add_product/view/addproduct_screen.dart';
import 'package:inv_management_app/features/sale_dir/view/cart_list_screen.dart';

import '../../../db/db_helper.dart';
import '../../../services/db_service.dart';
import '../../loading_screen_dir/view/sample_screen.dart';
import '../../sale_dir/view/sales_details_screen.dart';
import '../../sale_dir/view/sales_screen.dart';

class HomeProvider extends ChangeNotifier {

  final DatabaseHelper dbHelper;
  final ProductService service;


  HomeProvider({required this.dbHelper, required this.service});

  int _productCount = 0;

  int get productCount => _productCount;

  Future<void> fetchProductCount() async {
    try {
      final count = await service.totalProducts();
      _productCount = count;
      log("Count is "+count.toString());
      notifyListeners();
    } catch (e) {
      print('Error fetching product count: $e');
    }
  }


  void gotoForecast(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoadingScreen()));

  }

  void gotoMakeSales( BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));

  }

  void gotoAddProducts(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProductScreen()));
  }

  void gotosalesHistory(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SalesHistoryScreen()));

  }

  void initMethod() {
    fetchProductCount();
  }
}

