// lib/services/product_service.dart

import 'dart:developer';

import '../db/db_helper.dart';
import '../models/product_model.dart';

class ProductService {
  final DatabaseHelper _helper;

  ProductService(this._helper);

  Future<void> addProduct(Product product) async {
    await _helper.insertProduct(product);
  }

  Future<List<Product>> getProducts() async {
    return await _helper.getProducts();
  }

  Future<void> deleteProduct(int? productId) async {
    log('message to Delete');
    await _helper.deleteProduct(productId);
  }


  Future<int> totalProducts() async {
    // int total = await _helper.getProductCount();
    // return total;
    return await _helper.getProductCount();
  }


}
