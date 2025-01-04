import 'package:flutter/material.dart';
import 'package:inv_management_app/features/sale_dir/provider/sales_controller.dart';
import 'package:inv_management_app/models/sales_model.dart';
import 'package:inv_management_app/models/sales_product.dart';
import 'package:provider/provider.dart';



class SaleDetailsScreen extends StatelessWidget {
  final List<SalesProduct> saleDetails;

  SaleDetailsScreen({required this.saleDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sale Details')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: saleDetails.length,
                itemBuilder: (context, index) {
                  final detail = saleDetails[index];
                  return ListTile(
                    title: Text('Product Name: ${detail.product_name}'),
                    subtitle: Text('Quantity: ${detail.quantity}'),
                    trailing: Text('Price: \$${detail.selling_price}'),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class SalesHistoryScreen extends StatelessWidget {
  const SalesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SalesProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.newFetchProducts(context);
    });
    return Scaffold(
      appBar: AppBar(title: Text('Sale Details')),
      body: Consumer<SalesProvider>(
        builder: (context, provider, child) {
          if (provider.items.isEmpty) {
            return Center(child: Text('No sales available'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = provider.items[index];
                    return ListTile(
                      title: Text('Sale #${product.sales_id}'),
                      subtitle: Text('Date: ${product.sales_date}'),
                      trailing: Text('Total Amt: ${product.total_amount}'),
                      // trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaleDetailsScreen(
                                saleDetails: product.sales_item!),
                          ),
                        );
                      },
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
