/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/sales_controller.dart';

class SalesProductScreen extends StatelessWidget {
  const SalesProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Sales')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: salesProvider.products.length,
              itemBuilder: (context, index) {
                final product = salesProvider.products[index];
                return ListTile(

                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer<SalesProvider>(
                          builder: (context, salesProvider, child) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    product.product_name,
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Quantity',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => salesProvider.minusClicked(),
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
                                      Text(
                                        salesProvider.quantity.toString(),
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () => salesProvider.addClicked(),
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
                                    width: size.width,
                                    height: 56,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade800,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      onPressed: () {
                                        salesProvider.addToCart(0);
                                      },
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },

*/
/*
                  onTap: (){
                    showModalBottomSheet(context: context,
                        builder: (BuildContext context)  {
                      return Container(
                        padding: EdgeInsets.all(16),
                        height:  MediaQuery.of(context).size.height/3,
                        width:  MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 16,),
                            Text(product.product_name , style: Theme.of(context).textTheme.labelLarge,),

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
                                  onTap: () => salesProvider.minusClicked(),
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
                                Consumer(
                                  builder: (context, value, child) {
                                    return Text(salesProvider.quantity.toString(),
                                        style:
                                        Theme.of(context).textTheme.displaySmall!.copyWith(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ));
                                  }
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () => salesProvider.addClicked(),
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
                              width: size.width,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade800,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16))),
                                onPressed: () {
                                  salesProvider.addToCart(0);
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                          ],

                        ),
                      );
                        });
                  },
*/ /*

                  title: Text(product.product_name),
                  subtitle: Text('\$${product.selling_price.toStringAsFixed(2)}'),
*/
/*
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => salesProvider.removeFromCart(product.id!),
                      ),
                      Text(salesProvider.cart[product.id]?.toString() ?? '0'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => salesProvider.addToCart(product.id!),
                      ),
                    ],
                  ),
*/ /*

                );
              },
            ),
          ),
*/
/*
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
*/ /*

        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:inv_management_app/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../provider/sales_controller.dart';
import 'cart_list_screen.dart';

class SalesProductScreen extends StatelessWidget {
  const SalesProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salesProvider = Provider.of<SalesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Search"),
                    controller: salesProvider.searchController,
                    onChanged: (value) {
                      salesProvider.searchProducts(value);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    salesProvider.startBarcodeScan(context);
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
              itemCount: salesProvider.productList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = salesProvider.productList[index];
                return ListTile(

                  onTap: () {
                    salesProvider.product = product;
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer<SalesProvider>(
                          builder: (context, salesProvider, child) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    product.product_name!,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Quantity',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            salesProvider.minusClicked(),
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
                                      SizedBox(width: 16),
                                      Text(
                                        salesProvider.quantity.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(width: 16),
                                      GestureDetector(
                                        onTap: () => salesProvider.addClicked(),
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
                                    width: size.width,
                                    height: 56,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade800,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Add to cart with the specific product and current quantity
                                        for (int i = 0;
                                            i < salesProvider.quantity;
                                            i++) {

                                        }
                                        salesProvider.addToCart(CartItem(
                                            product_quantity:
                                            salesProvider.quantity,
                                            product: salesProvider.product), context);

                                        // Navigate to Cart Screen
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartScreen()));
                                        salesProvider.quantity = 0;
                                      },
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  title: Text(product.product_name!),
                  trailing: Text('rating: ${product.customer_rating}'),
                  subtitle:
                      Text('\$${product.selling_price?.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
