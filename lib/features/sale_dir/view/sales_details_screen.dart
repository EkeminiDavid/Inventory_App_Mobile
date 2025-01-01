import 'package:flutter/material.dart';
import 'package:inv_management_app/features/sale_dir/provider/sales_controller.dart';
import 'package:inv_management_app/models/sales_model.dart';
import 'package:inv_management_app/models/sales_product.dart';
import 'package:provider/provider.dart';

import '../../../db/db_helper.dart';

/*

class SalesHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.newFetchProducts(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales History'),
      ),
      body: FutureBuilder<List<SalesModel>>(
        future: Future.value(provider.items),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading sales history.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sales history available.'));
          } else {
            final sales = snapshot.data!;
            return ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, index) {
                final sale = sales[index];
                final saleId = sale.sales_id;
                final totalAmount = sale.sales_date;
                final saleDate = sale.sales_date;

                return ListTile(
                  title: Text('Sale #$saleId'),
                  // subtitle: Text('Date: ${DateTime.parse(saleDate).toLocal()}'),
                  // trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
                  onTap: () {
                */
/*    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaleDetailsScreen(saleId: saleId),
                      ),
                    );*/ /*

                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
*/

class SalesHistoryScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.newFetchProducts(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales History'),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.items.isEmpty // Handle empty state
              ? Center(child: Text('No sales history available.'))
              : ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    final sale = provider.items[index];
                    final saleId = sale.sales_id;
                    final totalAmount = sale.sales_date; // Fix variable
                    final saleDate = DateTime.parse(sale.sales_date!);

                    return ListTile(
                      title: Text('Sale #$saleId'),
                      subtitle: Text('Date: ${saleDate.toLocal()}'),
                      // trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
                      onTap: () {
                        /*      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SaleDetailsScreen(saleId: saleId),
                ),
              );*/
                      },
                    );
                  },
                ),
    );
  }
}

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
                    title: Text('Product ID: ${detail.id}'),
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
