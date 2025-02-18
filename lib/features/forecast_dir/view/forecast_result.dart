/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/forecast_controller.dart';

class ForecastResult extends StatelessWidget {
  const ForecastResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<PredictionProvider>(
            builder: (context, provider, child) {
              switch (provider.status) {
                case PredictionStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case PredictionStatus.error:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${provider.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async => await provider.fetchPredictions(
                            startDate: provider.formattedDateForServer,
                            endDate: provider.formattedEndDateForServer,
                            product: provider.productNameController.text,
                            customerRating: provider.selectedRating,
                            season: provider.selectedSeason,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );

                case PredictionStatus.loaded:
                  if (provider.predictionData == null) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }

                  final prediction = provider.predictionData!;
                  final firstWeek =
                      prediction.metadata.seasonalityEffects.entries.first;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SeasonalityPredictionsCard(
                          predictedQuantity: firstWeek.value.originalQuantity!,
                          originalQuantity: firstWeek.value.originalQuantity!,
                          seasonalityFactors: firstWeek.value.season,
                          weekDate: prediction.metadata.startDate,
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forecast Details',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                ListTile(
                                  leading: const Icon(Icons.inventory),
                                  title: const Text('Product'),
                                  subtitle: Text(prediction.metadata.product),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.date_range),
                                  title: const Text('Forecast Period'),
                                  subtitle: Text(
                                    '${prediction.metadata.startDate.toString().split(' ')[0]} to '
                                    '${prediction.metadata.endDate.toString().split(' ')[0]}',
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.shopping_cart),
                                  title: const Text('Total Predicted Quantity'),
                                  subtitle: Text(
                                    prediction.metadata.totalPredictedQuantity
                                        .toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                case PredictionStatus.initial:
                  return const Center(
                    child: Text('No predictions loaded yet'),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class SeasonalityPredictionsCard extends StatelessWidget {
  final double predictedQuantity;
  final double originalQuantity;
  final List<String> seasonalityFactors;
  final DateTime weekDate;

  const SeasonalityPredictionsCard({
    Key? key,
    required this.predictedQuantity,
    required this.originalQuantity,
    required this.seasonalityFactors,
    required this.weekDate,
  }) : super(key: key);

  String _formatWeekDate(DateTime date) {
    final formatter = DateFormat('MMM dd, yyyy');
    return 'Week of ${formatter.format(date)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Whiteboard Demand Forecast',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              _formatWeekDate(weekDate),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            _buildPredictionRow(
              'Adjusted Prediction',
              predictedQuantity,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildPredictionRow(
              'Base Prediction',
              originalQuantity,
              Colors.blue,
            ),
            const SizedBox(height: 24),
            if (seasonalityFactors.isNotEmpty) ...[
              Text(
                'Seasonality Factors:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...seasonalityFactors.map((factor) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.event, size: 16),
                        const SizedBox(width: 8),
                        Text(factor),
                      ],
                    ),
                  )),
            ],
            const SizedBox(height: 16),
            _buildImpactIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionRow(String label, double value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactIndicator() {
    final impact =
        ((predictedQuantity - originalQuantity) / originalQuantity * 100)
            .round();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'Seasonal Impact: +$impact%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/sales_prediction.dart';
import '../provider/forecast_controller.dart';

class ForecastResult extends StatelessWidget {
  const ForecastResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PredictionProvider>(
        builder: (context, provider, child) {
          switch (provider.status) {
            case PredictionStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PredictionStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${provider.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async => await provider.fetchPredictions(
                        startDate: provider.formattedDateForServer,
                        endDate: provider.formattedEndDateForServer,
                        product: provider.productNameController.text,
                        customerRating: provider.selectedRating,
                        season: provider.selectedSeason,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case PredictionStatus.loaded:
              if (provider.predictionData == null) {
                return const Center(child: Text('No data available'));
              }

              final prediction = provider.predictionData!;
              final firstWeek = prediction.metadata.seasonalityEffects.entries.first;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SeasonalityPredictionsCard(
                      predictedQuantity: firstWeek.value.predictedQuantity,
                      originalQuantity: 0.0, // You'll need to provide original quantity
                      seasonalityFactors: firstWeek.value.season,
                      weekDate: prediction.metadata.startDate,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Forecast Details',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            ListTile(
                              leading: const Icon(Icons.inventory),
                              title: const Text('Product'),
                              subtitle: Text(prediction.metadata.product),
                            ),
                            ListTile(
                              leading: const Icon(Icons.date_range),
                              title: const Text('Forecast Period'),
                              subtitle: Text(
                                  '${prediction.metadata.startDate.toString().split(' ')[0]} to '
                                      '${prediction.metadata.endDate.toString().split(' ')[0]}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.shopping_cart),
                              title: const Text('Total Predicted Quantity'),
                              subtitle: Text(
                                  prediction.metadata.totalPredictedQuantity.toString()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            case PredictionStatus.initial:
              return const Center(child: Text('No predictions loaded yet'));
          }
        },
      ),
    );
  }
}

class SeasonalityPredictionsCard extends StatelessWidget {
  final double predictedQuantity;
  final double originalQuantity;
  final List<String> seasonalityFactors;
  final DateTime weekDate;

  const SeasonalityPredictionsCard({
    Key? key,
    required this.predictedQuantity,
    required this.originalQuantity,
    required this.seasonalityFactors,
    required this.weekDate,
  }) : super(key: key);

  String _formatWeekDate(DateTime date) {
    final formatter = DateFormat('MMM dd, yyyy');
    return 'Week of ${formatter.format(date)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Whiteboard Demand Forecast',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              _formatWeekDate(weekDate),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildPredictionRow(
              'Adjusted Prediction',
              predictedQuantity,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildPredictionRow(
              'Base Prediction',
              originalQuantity,
              Colors.blue,
            ),
            const SizedBox(height: 24),
            if (seasonalityFactors.isNotEmpty) ...[
              Text(
                'Seasonality Factors:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...seasonalityFactors.map((factor) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.event, size: 16),
                    const SizedBox(width: 8),
                    Text(factor),
                  ],
                ),
              )),
            ],
            const SizedBox(height: 16),
            _buildImpactIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionRow(String label, double value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactIndicator() {
    final impact =
    ((predictedQuantity - originalQuantity) / originalQuantity * 100)
        ;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'Seasonal Impact: +$impact%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}