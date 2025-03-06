import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inv_management_app/features/add_product/view/addproduct_screen.dart';
import 'package:inv_management_app/features/sale_dir/view/cart_list_screen.dart';
import 'package:provider/provider.dart';

import '../../../db/db_helper.dart';
import '../../../services/db_service.dart';
import '../../forecast_dir/view/forecast_screen.dart';
import '../../loading_screen_dir/view/sample_screen.dart';
import '../../productList_dir/provider/product_list_controller.dart';
import '../../sale_dir/view/sales_details_screen.dart';
import '../../sale_dir/view/sales_screen.dart';

class HomeProvider extends ChangeNotifier {



  int _productCount = 0;

  int get productCount => _productCount;

  Future<void> fetchProductCount(BuildContext context) async {
    try {
      final result =
          await Provider.of<ProductListProvider>(context, listen: false);
      await result.newFetchProducts(context);
      _productCount = result.items.length;
      notifyListeners();

      // log("Count is "+count.toString());
    } catch (e) {
      print('Error fetching product count: $e');
    }
  }

  void gotoForecast(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForecastScreen()));
  }

  void gotoMakeSales(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  void gotoAddProducts(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProductScreen()));
  }

  void gotosalesHistory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SalesHistoryScreen()));
  }

  void initMethod(BuildContext context) {
    fetchProductCount(context);
  }
}
