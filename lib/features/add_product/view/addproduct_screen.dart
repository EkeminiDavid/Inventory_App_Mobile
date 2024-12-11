import 'package:flutter/material.dart';
import 'package:inv_management_app/features/add_product/provider/addproduct_controller.dart';
import 'package:provider/provider.dart';

import '../../../components/universal/universal_settings.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Provider.of<AddProductProvider>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Barcode',
                      style: themeModel.lightTheme.textTheme.bodyMedium,
                    )),
                SizedBox(
                  width: size.width,
                  height: size.height / 72,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.barcodeController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.startBarcodeScan(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.barcode_reader,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Product Name',
                      style: themeModel.lightTheme.textTheme.bodyMedium,
                    )),
                SizedBox(
                  width: size.width,
                  height: size.height / 72,
                ),
                TextField(
                  controller: controller.productNameController,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Unit of Measurement',
                      style: themeModel.lightTheme.textTheme.bodyMedium,
                    )),
                SizedBox(
                  width: size.width,
                  height: size.height / 72,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade200,
                  ),
                  width: size.width,
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      value: controller.selectedUnit,
                      hint: Text('Select Unit of Measurement'),
                      items: controller.units.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (newValue) {
                        controller.selectUnit(newValue!);
                      }),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Cost Price',
                      style: themeModel.lightTheme.textTheme.bodyMedium,
                    )),
                SizedBox(
                  width: size.width,
                  height: size.height / 72,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.costPriceController,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 80,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Selling Price'),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 72,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.sellingPriceController,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Quantity',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.minusClicked(),
                      child: Card(
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(
                            Icons.remove_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(controller.quantity.toString(),
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () => controller.addClicked(),
                      child: Card(
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      controller.addNewProduct(context);
                    },
                    child: const Text(
                      'Add Products',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
