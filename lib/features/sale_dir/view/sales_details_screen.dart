import 'package:flutter/material.dart';

import '../../../db/db_helper.dart';




class SalesHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getSalesHistory(),
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
                final saleId = sale['${DatabaseHelper().entities.saleId}'];
                final totalAmount = sale['${DatabaseHelper().entities.saleTotal}'];
                final saleDate = sale['${DatabaseHelper().entities.saleDate}'];

                return ListTile(
                  title: Text('Sale #$saleId'),
                  subtitle: Text('Date: ${DateTime.parse(saleDate).toLocal()}'),
                  trailing: Text('\$${totalAmount.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaleDetailsScreen(saleId: saleId),
                      ),
                    );
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

class SaleDetailsScreen extends StatelessWidget {
  final int saleId;

  SaleDetailsScreen({required this.saleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sale Details')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getSaleDetails(saleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading sale details.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found for this sale.'));
          } else {
            final saleDetails = snapshot.data!;
            return ListView.builder(
              itemCount: saleDetails.length,
              itemBuilder: (context, index) {
                final detail = saleDetails[index];
                return ListTile(
                  title: Text('Product ID: ${detail['productId']}'),
                  subtitle: Text('Quantity: ${detail['quantity']}'),
                  trailing: Text('Price: \$${detail['price']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
