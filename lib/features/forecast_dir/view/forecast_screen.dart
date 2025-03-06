// prediction_screen.dart
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:inv_management_app/utils/drop_down.dart';
import 'package:inv_management_app/utils/season_dropdown.dart';
import 'package:provider/provider.dart';
import '../../../components/universal/universal_settings.dart';

import '../../../models/item_model.dart';
import '../provider/forecast_controller.dart';
import 'forecast_result.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late PredictionProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<PredictionProvider>(context, listen: false);
  }

  double selectedRating = 0.0;
  String selectedEvent = 'Normal';

  void _onRatingSelected(double rating) {
    setState(() {
      selectedRating = rating;
      provider.selectedRating = selectedRating;
    });
    print('Selected Rating: $rating');
  }

  void _onSeasonSelected(String event) {
    setState(() {
      selectedEvent = event;
      provider.selectedSeason = selectedEvent;
    });
    print('Selected Event: $event');
  }



  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PredictionProvider>(context, listen: false);
    final themeModel = Provider.of<ThemeModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.initMethod(context);
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Demand Predictions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Enter Product name',
                              style: themeModel.lightTheme.textTheme.bodyMedium,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: themeModel.lightTheme.textTheme.bodyMedium,
                            )),
                        TextField(
                          onTap: () {
                            provider.selectStartDate(context);
                          },
                          controller: provider.startDateController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Select End Date',
                              style: themeModel.lightTheme.textTheme.bodyMedium,
                            )),
                        TextField(
                          onTap: () {
                            provider.selectEndDate(context);
                          },
                          controller: provider.endDateController,
                        ),
                        SizedBox(height: 16,),
                        StarRatingDropdown(selectedRating: selectedRating, onRatingSelected: _onRatingSelected,),
                        SizedBox(height: 16,),
                        SeasonDropdown(selectedEvent: selectedEvent, onEventSelected: _onSeasonSelected)
                      ],
                    ),
                  ),
                ],
              ),
            ),
        
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 32,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  provider.runForecast(context);
                  selectedRating = 0.0;
                  selectedEvent = 'Normal';
                  },
                child: const Text(
                  'Forcast',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
