import 'dart:convert';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inv_management_app/components/universal/toast_widget.dart';
import 'package:inv_management_app/features/productList_dir/provider/product_list_controller.dart';
import 'package:inv_management_app/models/item_model.dart';
import 'package:inv_management_app/models/sales_prediction.dart';
import 'package:inv_management_app/network/network_client.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


/*
class ForecastController extends ChangeNotifier {
  final productNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  NetworkService networkService = NetworkService();
  DateTime selectedDate = DateTime.now();
  var formattedDate = '';
  var formattedDateForServer = '';
  bool callSuccesfull = false;

  var formattedEndDate = '';
  var formattedEndDateForServer = '';

  PredictionResponse predictionData = PredictionResponse(
      predictions: {},
      metadata: PredictionMetadata(
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          product: '',
          seasonalityEffects: {},
          totalPredictedQuantity: 0,
          totalWeeks: 0),
      message: '',
      statusCode: 0);

  List<ItemModel> newList = [];

  List<BarChartGroupData> getBarGroups() {
    int index = 0;
    return predictionData.body.predictions.entries.map((entry) {
      return BarChartGroupData(
        x: index++,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.blue,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
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

    showLoader(context);
    var body = {
      "product_name": productNameController.text,
      "start_date": formattedDateForServer,
      "end_date": formattedEndDateForServer
    };

    final result = await networkService.predictProduct(body);
    hideLoader();
    if (result.statusCode == 200) {
      // newSuccessSnack(context, "${result.data.toString()}");
      callSuccesfull = true;
      PredictionResponse prediction =
      PredictionResponse.fromJson(jsonDecode(result.data));
      predictionData = prediction;

      notifyListeners();
      log(prediction.message);
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
}
*/


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
  var formattedDate = '';
  var formattedDateForServer = '';
  bool callSuccesfull = false;
  List<ItemModel> newList = [];


  var formattedEndDate = '';
  var formattedEndDateForServer = '';

  PredictionStatus _status = PredictionStatus.initial;
  PredictionResponse? _predictionData;
  String? _error;

  PredictionStatus get status => _status;
  PredictionResponse? get predictionData => _predictionData;
  String? get error => _error;

  Future<void> fetchPredictions({
    required String startDate,
    required String endDate,
    required String product,
  }) async {
    try {
      _status = PredictionStatus.loading;
      notifyListeners();

      // Create the request body
      final Map<String, dynamic> requestBody = {
        'start_date': startDate,
        'end_date': endDate,
        'product_name': product,
      };
      print(requestBody);

      final response = await http.post(
        Uri.parse('https://inventory-app-1-7daj.onrender.com/predict_quantity'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print(response.body);
        _predictionData = PredictionResponse.fromJson(jsonDecode(response.body));
        _status = PredictionStatus.loaded;
      } else {
        _error = 'Failed to load predictions: ${response.statusCode}';
        _status = PredictionStatus.error;
      }
    } catch (e) {
      _error = 'Error fetching predictions: $e';
      _status = PredictionStatus.error;
    }
    notifyListeners();
  }
  void reset() {
    _status = PredictionStatus.initial;
    _predictionData = null;
    _error = null;
    notifyListeners();
  }

  double getSeasonalityImpact(String week) {
    final effect = _predictionData?.metadata.seasonalityEffects[week];
    if (effect != null) {
      return ((effect.adjustedQuantity - effect.originalQuantity) /
          effect.originalQuantity * 100);
    }
    return 0.0;
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

    // showLoader(context);
    var body = {
      "product_name": productNameController.text,
      "start_date": formattedDateForServer,
      "end_date": formattedEndDateForServer
    };

   await fetchPredictions(
          startDate: formattedDateForServer,
          endDate: formattedEndDateForServer,
          product: productNameController.text,
        );


/*
    final result = await networkService.predictProduct(body);
    hideLoader();
    if (result.statusCode == 200) {
      // newSuccessSnack(context, "${result.data.toString()}");
      callSuccesfull = true;
      PredictionResponse prediction =
      PredictionResponse.fromJson(jsonDecode(result.data));
      predictionData = prediction;

      notifyListeners();
      log(prediction.message);
    }*/
  }
}
