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
      body: ResponseBody(
          metadata: Metadata(
              endDate: "",
              product: "",
              startDate: "",
              totalPredictedQuantity: 0,
              totalWeeks: 0),
          predictions: {}),
      message: "",
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

  void runForecast(BuildContext context) async {
    callSuccesfull = false;

    if (productNameController.text == "" || startDateController.text.isEmpty || endDateController.text.isEmpty) {
      newErrorSnack(
          context, "Confirm that you have choosen the Product and Selected Start Date and End Date");
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

      formattedDateForServer =
          DateFormat('yyyy-MM-dd').format(selectedDate);

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
      formattedEndDateForServer =
          DateFormat('yyyy-MM-dd').format(selectedDate);
      notifyListeners();

    }
  }


}
