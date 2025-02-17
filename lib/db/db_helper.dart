// services/database_helper.dart
/*
import 'dart:developer';

import 'package:inv_management_app/db/data_entities.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  DataEntities entities = DataEntities();

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE ${entities.tableName} (
          ${entities.productId} INTEGER PRIMARY KEY AUTOINCREMENT,
           ${entities.product_name} TEXT,
            ${entities.selling_price} REAL, 
            ${entities.product_barcode} TEXT,
            ${entities.cost_price} REAL, 
            ${entities.unit_of_measurement} TEXT, 
            ${entities.quantity} INTEGER)''',
        );

        await db.execute('''
        CREATE TABLE ${entities.salesTable} (
          ${entities.saleId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${entities.saleDate} TEXT,
          ${entities.saleTotal} REAL
        )''');

        await db.execute('''
        CREATE TABLE ${entities.saleDetailsTable} (
          ${entities.saleDetailId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${entities.saleDetailSaleId} INTEGER,
          ${entities.saleDetailProductId} INTEGER,
          ${entities.saleDetailQuantity} INTEGER,
          ${entities.saleDetailPrice} REAL,
          FOREIGN KEY (${entities.saleDetailSaleId}) REFERENCES ${entities.salesTable}(${entities.saleId}),
          FOREIGN KEY (${entities.saleDetailProductId}) REFERENCES ${entities.tableName}(${entities.productId})
        )''');
      },
    );
  }

  Future<void> addProduct(Product product) async {
    final db = await database;

    await db.insert(
      entities.tableName,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(entities.tableName);
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<int> getProductCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM products');
    return Sqflite.firstIntValue(result) ?? 0;
  }


  Future<void> deleteProduct(int? productId) async {
    try {
      final db = await database; // Ensure the database is opened

      // Check if the product exists
      final count = await db.rawDelete(
          'DELETE FROM ${entities.tableName} WHERE ${entities.productId} = ?',
          [productId]
      );

      log('Deleted $count product(s)');

      // Check if any products were actually deleted
      if (count == 0) {
        throw Exception('Product not found');
      }
    } catch (e) {
      log('Error deleting product: $e');
      rethrow; // Re-throw the exception to handle it in the calling method
    }
  }


  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }


  Future<void> addSale(DateTime saleDate, double totalAmount) async {
    final db = await database;
    await db.insert(
      entities.salesTable,
      {
        entities.saleDate: saleDate.toIso8601String(),
        entities.saleTotal: totalAmount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getSales() async {
    final db = await database;
    return await db.query(entities.salesTable);
  }


  Future<List<Map<String, dynamic>>> getSaleDetails(int saleId) async {
    final db = await database;
    return await db.query(
      entities.saleDetailsTable,
      where: '${entities.saleDetailSaleId} = ?',
      whereArgs: [saleId],
    );
  }

  Future<List<Map<String, dynamic>>> getSalesHistory() async {
    final db = await database;
    return await db.query(
      entities.salesTable,
      orderBy: '${entities.saleDate} DESC', // Sort by most recent
    );
  }

}
*/
