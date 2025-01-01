/*
import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/models/item_model.dart';
import 'package:provider/provider.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';

import '../provider/forecast_controller.dart';

class ForecastScreen1 extends StatelessWidget {
  const ForecastScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final controller = Provider.of<ForecastController>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.initMethod(context);
    });

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<ForecastController>(
          builder: (context, ForecastController controller, snapshot) {
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
                                'Product name',
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
                              onChanged: (value) {
                                // controller.sellingPriceController.clear();
                              },
                              controller: controller.productNameController,
                              // style: primaryTextStyle(),
                              */
/*decoration: inputDecoration(
                                    hintText: "e.g Chivita",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppPalette.grey.gray350,
                                        fontFamily: GoogleFonts.dmSans().fontFamily),
                                    radius: 10.0,
                                    fillColor: AppPalette.grey.gray150,
                                    borderColor: AppPalette.transparent)*//*

                            ),
                            // validator: (name) => controller.validateName(name!),
                            onSuggestionSelected: (ItemModel suggestion) {
                              controller.productNameController.text =
                                  suggestion.product_name ?? '';
                              // controller.appendText(suggestion);
                            },
                            suggestionsCallback: (String pattern) async {
                              List<ItemModel> suggestions =
                                  await controller.searchProducts(pattern);
                              return suggestions;
                            },
                            itemBuilder:
                                (BuildContext context, ItemModel itemData) {
                              return GestureDetector(
                                onTap: () {
                                  print('john ${itemData.toString()}');
                                  controller.productNameController.text =
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
                                'Select Month',
                                style: themeModel.lightTheme.textTheme.bodyMedium,
                              )),

                          TextField(),
                          Container(
                            margin: EdgeInsets.only(bottom: 24),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey.shade200,
                            ),
                            width: size.width,
                            child: DropdownButton(
                                dropdownColor: Colors.white,
                                value: controller.selectedMonth,
                                hint: Text('Select Month'),
                                items: controller.units.map((String item) {
                                  return DropdownMenuItem(
                                      value: item, child: Text(item));
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectMonth(newValue!);
                                }),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, ),
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade800,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          controller.runForecast(context);
                        },
                        child: const Text(
                          'Go',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Predicted Product: ${controller.productNameText}',
                            style: themeModel.lightTheme.textTheme.bodyMedium,
                          )),
                        SizedBox(height: 16,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prediction:',
                            style: themeModel.lightTheme.textTheme.bodyMedium,
                          )),
                      SizedBox(height: 16,),


                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            controller.predictionText,
                            style: themeModel.lightTheme.textTheme.bodyMedium,
                          )),
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
*/
