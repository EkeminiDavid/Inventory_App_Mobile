import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/features/productList_dir/provider/product_list_controller.dart';
import 'package:inv_management_app/features/sample_dir/provider/sample_controller.dart';
import 'package:provider/provider.dart';

import '../../add_product/view/addproduct_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductListProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initMethod();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          SizedBox(
            height: 60,
            width: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductScreen()),
                  ).then((_) {
                    Provider.of<ProductListProvider>(context, listen: false)
                        .fetchProducts();
                  });
                },
                tooltip: 'Add New Product',
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, provider, child) {
          if (provider.products.isEmpty) {
            return Center(child: Text('No products available'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: "Search"),
                        controller: provider.searchController,
                        onChanged: (value) {
                          provider.searchProducts(value);
                        },
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.productList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return ListTile(
                      title: Text(product.product_name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selling Price: ${product.selling_price}'),
                          Text('Cost Price: ${product.cost_price}'),
                          Text('Quantity: ${product.quantity}'),
                          Text('Unit: ${product.unit_of_measurement}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text(
                                    'Are you sure you want to delete ${product.product_name}?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () async {
                                      await Provider.of<ProductListProvider>(
                                              context,
                                              listen: false)
                                          .deleteProduct(product.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
