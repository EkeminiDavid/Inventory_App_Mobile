import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inv_management_app/components/universal/toast_widget.dart';
import 'package:inv_management_app/features/forecast_dir/view/forecast_screen.dart';
import 'package:inv_management_app/features/productList_dir/provider/product_list_controller.dart';
import 'package:inv_management_app/models/item_model.dart';
import 'package:inv_management_app/models/sales_prediction.dart';
import 'package:inv_management_app/network/network_client.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../view/forecast_result.dart';

enum PredictionStatus {
  initial,
  loading,
  loaded,
  error,
}

class PredictionProvider extends ChangeNotifier {
  final productNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  NetworkService networkService = NetworkService();
  DateTime selectedDate = DateTime.now();
  double selectedRating = 0.0;
  String selectedSeason = '';
  String formattedDate = '';
  String formattedDateForServer = '';
  bool callSuccesfull = false;
  List<ItemModel> newList = [];

  String formattedEndDate = '';
  String formattedEndDateForServer = '';

  PredictionStatus _status = PredictionStatus.initial;
  PredictionResponse? _predictionData;
  String? _error;

  PredictionStatus get status => _status;

  PredictionResponse? get predictionData => _predictionData;

  String? get error => _error;

/*  Future<int> fetchPredictions({
    required String startDate,
    required String endDate,
    required String product,
    required double customerRating,
    required String season,
  }) async {
    try {
      _status = PredictionStatus.loading;
      notifyListeners();

      final Map<String, dynamic> requestBody = {
        'start_date': startDate,
        'end_date': endDate,
        'product_name': product,
        "customer_rating": customerRating,
        "season": season
      };

      final response = await http.post(
        Uri.parse('https://inventory-app-1-7daj.onrender.com/predict_quantity'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        _predictionData = PredictionResponse.fromJson(jsonDecode(response.body));
        _status = PredictionStatus.loaded;
        notifyListeners();
        return 1;
      } else {
        _error = 'Failed to load predictions: ${response.statusCode}';
        _status = PredictionStatus.error;
        notifyListeners();
        return 0;
      }
    } catch (e) {
      _error = 'Error fetching predictions: $e';
      _status = PredictionStatus.error;
      notifyListeners();
      return 0;
    }
  }*/

  void reset() {
    _status = PredictionStatus.initial;
    _predictionData = null;
    _error = null;
    notifyListeners();
  }

/*  double getSeasonalityImpact(String week) {
    final effect = _predictionData?.metadata.seasonalityEffects[week];
    if (effect != null) {
      return ((effect.predictedQuantity - effect.originalQuantity!) /
          effect.originalQuantity! *
          100);
    }
    return 0.0;
  }*/

  Future<PredictionResponse?> fetchPredictions({
    required String startDate,
    required String endDate,
    required String product,
    required double customerRating,
    required String season,
  }) async {
    try {
      _status = PredictionStatus.loading;
      notifyListeners();

      final Map<String, dynamic> requestBody = {
        'start_date': startDate,
        'end_date': endDate,
        'product_name': product,
        "customer_rating": customerRating,
        "season": season
      };

      final response = await http.post(
        Uri.parse('https://inventory-app-1-7daj.onrender.com/predict_quantity'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        _predictionData =
            PredictionResponse.fromJson(jsonDecode(response.body));
        _status = PredictionStatus.loaded;
        log('ForeCast Result ${response.body}');
        notifyListeners();
        return _predictionData;
      } else {
        _error = 'Failed to load predictions: ${response.statusCode}';
        _status = PredictionStatus.error;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _error = 'Error fetching predictions: $e';
      _status = PredictionStatus.error;
      notifyListeners();
      return null;
    }
  }

  initMethod(BuildContext context) {
    newList = Provider.of<ProductListProvider>(context, listen: false).items;
  }

  Future<List<ItemModel>> searchProducts(String pattern) async {
    List<ItemModel> filteredProducts = newList
        .where((product) =>
            product.product_name!.toLowerCase().contains(pattern.toLowerCase()))
        .toList();

    return filteredProducts;
  }

  Future selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formattedDate = DateFormat('dd-MMM-yyyy').format(selectedDate);
      startDateController.text = formattedDate.toString();

      formattedDateForServer = DateFormat('yyyy-MM-dd').format(selectedDate);

      notifyListeners();
    }
  }

  Future selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formattedEndDate = DateFormat('dd-MMM-yyyy').format(selectedDate);
      endDateController.text = formattedEndDate.toString();
      formattedEndDateForServer = DateFormat('yyyy-MM-dd').format(selectedDate);
      notifyListeners();
    }
  }

  void runForecast(BuildContext context) async {
    callSuccesfull = false;

    if (productNameController.text == "" ||
        startDateController.text.isEmpty ||
        endDateController.text.isEmpty) {
      newErrorSnack(context,
          "Confirm that you have choosen the Product and Selected Start Date and End Date");
      return;
    }
    final result = await fetchPredictions(
      startDate: formattedDateForServer,
      endDate: formattedEndDateForServer,
      product: productNameController.text,
      customerRating: selectedRating,
      season: selectedSeason,
    );
    if (_status == PredictionStatus.loaded) {
      // Check the status *after* fetchPredictions completes
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PredictionScreen(
                  predictionResponse: result!,
                )),
      );
      productNameController.clear();
      endDateController.clear();
      startDateController.clear();
      selectedSeason = '';
      selectedRating = 0.0;
    } else if (_status == PredictionStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_error!)), // Show the error message
      );
    }
  }
}
