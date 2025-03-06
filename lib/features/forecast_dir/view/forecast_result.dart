import 'package:flutter/material.dart';
import 'package:inv_management_app/utils/scanner.dart';

import '../../../models/sales_prediction.dart';
import '../widgets/bar_chart.dart';

class PredictionScreen extends StatelessWidget {
  final PredictionResponse predictionResponse;

  const PredictionScreen({Key? key, required this.predictionResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seasons = predictionResponse.metadata.seasonalityEffects.values
        .map((effect) => effect.season.join(", "))
        .toSet() // Remove duplicates
        .join(", "); // Combine into a single string


    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Predictions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${predictionResponse.metadata.product}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Start Date: ${predictionResponse.metadata.startDate}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'End Date: ${predictionResponse.metadata.endDate}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Season: $seasons',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              // 'Total Predicted Quantity: ${predictionResponse.metadata.totalPredictedQuantity}',
              'Total Predicted Quantity: ${roundDouble(predictionResponse.metadata.totalPredictedQuantity, 2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Weekly Predictions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 300, // Set a fixed height for the chart
              padding: const EdgeInsets.all(8.0),
              child: PredictionBarChart(
                predictions: predictionResponse.predictions,
                seasonalityEffects: predictionResponse.metadata.seasonalityEffects,
              ),
            ),
          ],
        ),
      ),
    );
  }
}