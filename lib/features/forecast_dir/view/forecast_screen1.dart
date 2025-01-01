// prediction_models.dart
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inv_management_app/features/forecast_dir/provider/forecast_controller.dart';
import 'package:provider/provider.dart';

import '../../../components/universal/universal_settings.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/item_model.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ForecastController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.initMethod(context);
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<ForecastController>(
              builder: (context, ForecastController controller, snapshot) {
            final metadata = provider.predictionData.body.metadata;

            return Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter Product name',
                                style:
                                    themeModel.lightTheme.textTheme.bodyMedium,
                              )),
                          DropDownSearchFormField<ItemModel>(
                            hideOnEmpty: true,
                            hideOnError: true,
                            noItemsFoundBuilder: (context) {
                              return const SizedBox();
                            },
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(),
                            textFieldConfiguration: TextFieldConfiguration(
                              onChanged: (value) {},
                              controller: provider.productNameController,
                            ),
                            onSuggestionSelected: (ItemModel suggestion) {
                              provider.productNameController.text =
                                  suggestion.product_name ?? '';
                              // controller.appendText(suggestion);
                            },
                            suggestionsCallback: (String pattern) async {
                              List<ItemModel> suggestions =
                                  await provider.searchProducts(pattern);
                              return suggestions;
                            },
                            itemBuilder:
                                (BuildContext context, ItemModel itemData) {
                              return GestureDetector(
                                onTap: () {
                                  print('john ${itemData.toString()}');
                                  provider.productNameController.text =
                                      itemData.product_name ?? '';
                                  // controller.appendText(itemData);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(itemData.product_name ?? ''),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Select Start Date',
                                style:
                                    themeModel.lightTheme.textTheme.bodyMedium,
                              )),
                          TextField(
                            onTap: () {
                              controller.selectStartDate(context);
                            },
                            controller: controller.startDateController,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Select End Date',
                                style:
                                    themeModel.lightTheme.textTheme.bodyMedium,
                              )),
                          TextField(
                            onTap: () {
                              controller.selectEndDate(context);
                            },
                            controller: controller.endDateController,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 8,
                      ),
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade800,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          provider.runForecast(context);
                        },
                        child: const Text(
                          'Go',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                provider.callSuccesfull == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Text(
                            '${metadata.product} Predictions',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            '${metadata.startDate} to ${metadata.endDate}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.green.shade700),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    provider.predictionData.message,
                                    style:
                                        TextStyle(color: Colors.green.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Total Predicted',
                                  value: metadata.totalPredictedQuantity
                                      .toString(),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _SummaryCard(
                                  title: 'Total Weeks',
                                  value: metadata.totalWeeks.toString(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          Container(
                            height: 200,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 60,
                                barGroups: provider.getBarGroups(),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        final weekNum = provider.predictionData
                                            .body.predictions.keys
                                            .elementAt(value.toInt())
                                            .split('-')[1];
                                        return Text(
                                          weekNum,
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(show: false),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          Text(
                            'Weekly Breakdown',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          ...provider.predictionData.body.predictions.entries
                              .map((entry) => _WeeklyItem(
                                    week: entry.key.split('-')[1],
                                    value: entry.value,
                                  )),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 6,
                          ),
                          Assets.icons.printer.svg(height: size.height / 10),
                          Text(
                            'No Forecast to Display',
                            style: themeModel.lightTheme.textTheme.bodyMedium,
                          )
                        ],
                      )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyItem extends StatelessWidget {
  final String week;
  final int value;

  const _WeeklyItem({
    required this.week,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Week $week'),
          Text(
            '$value units',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
