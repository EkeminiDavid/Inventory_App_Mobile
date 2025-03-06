import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/sales_prediction.dart';

class PredictionBarChart extends StatelessWidget {
  final Map<String, double> predictions;
  final Map<String, SeasonalityEffect> seasonalityEffects;

  const PredictionBarChart({
    Key? key,
    required this.predictions,
    required this.seasonalityEffects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = predictions.entries.map((entry) {
      final week = entry.key;
      final quantity = entry.value;

      return BarChartGroupData(
        x: predictions.keys.toList().indexOf(week), // X-axis index
        barRods: [
          BarChartRodData(
            toY: quantity,
            color: Colors.blue,
            width: 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: quantity + 50, // Optional: Add a background bar
              color: Colors.grey[200],
            ),
          ),
        ],
        showingTooltipIndicators: [0], // Show tooltip for this bar
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: barGroups,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta){
              return Text(
                value.toInt().toString(),
                style: TextStyle(fontSize: 9), // Adjust text size here
              );
            }),

          ),
          rightTitles: AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final week = predictions.keys.toList()[value.toInt()];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: Text(
                    week,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            fitInsideVertically: true,
            tooltipMargin: 8,
            tooltipPadding: EdgeInsets.all(2),
            tooltipBgColor: Colors.blue,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final week = predictions.keys.toList()[group.x.toInt()];
              return BarTooltipItem(
                '$week\nQty: ${rod.toY}',
                TextStyle(color: Colors.white, fontSize: 9),
              );
            },
          ),
        ),
      ),
    );
  }
}