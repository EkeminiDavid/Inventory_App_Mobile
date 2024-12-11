import 'package:flutter/material.dart';
import 'package:inv_management_app/features/sale_dir/view/sales_screen.dart';
import 'package:provider/provider.dart';
import '../provider/sales_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              // Navigate to Sales Product Screen to add more items
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesProductScreen())
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: salesProvider.cart.isEmpty
                ? Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: salesProvider.cart.length,
              itemBuilder: (context, index) {
                final productId = salesProvider.cart.keys.elementAt(index);
                final quantity = salesProvider.cart[productId]!;
                final product = salesProvider.products.firstWhere((p) => p.id == productId);

                return ListTile(
                  title: Text(product.product_name),
                  subtitle: Text('\$${product.selling_price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => salesProvider.removeFromCart(productId),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => salesProvider.addToCart(productId),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${salesProvider.calculateTotal().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await salesProvider.completeSale(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sale completed!')),
                    );
                  },
                  child: Text('Complete Sale'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      floatingActionButton:
      InkWell(
        onTap: () {
          salesProvider.gotoProductList(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            // color: Colors.blue,
              color: Color(0xffDBF8FF),
              borderRadius: BorderRadius.circular(16)),
          height: size!.height / 10.8,
          width: size.height / 5.8,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size!.width / 12,
                  width: size!.width / 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff109EC0),
                  ),
                  child: Center(
                    child: Assets.icons.icons8Buy.svg(),
                  ),
                ),
                Text('Make Sales')
              ],
            ),
          ),
        ),
      ),
      */
/*FloatingActionButton(
        child: Column(
          children: [
            Container(
              height: size!.width / 6,
              width: size!.width / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff109EC0),
              ),
              child: Center(
                child: Assets.icons.icons8Buy.svg(),
              ),
            ),
            Text('Make Sales')
          ],
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SalesProductScreen()));
        },
      ),*//*

      body: salesProvider.cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: salesProvider.cart.length,
              itemBuilder: (context, index) {
                final cartItem = salesProvider.cart.entries.toList()[index];
                final productId = cartItem.key;
                final quantity = cartItem.value;
                final product =
                    salesProvider.products.firstWhere((p) => p.id == productId);

                return ListTile(
                  title: Text(product.product_name),
                  subtitle: Text(
                    'Price: \$${product.selling_price.toStringAsFixed(2)} x $quantity',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () =>
                            salesProvider.removeFromCart(productId),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () => salesProvider.addToCart(productId),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: \$${salesProvider.calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await salesProvider.completeSale(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sale completed!')),
                );
                Navigator.pop(context);
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
