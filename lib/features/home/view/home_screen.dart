import 'package:flutter/material.dart';
import 'package:inv_management_app/features/home/provider/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeProvider>(context, listen: false);
    final size = MediaQuery.maybeOf(context)?.size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initMethod(context);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                        color: Color(0xffE1F4F0),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    height: size!.height / 10.8,
                    width: size.height / 5.8,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text('Total Products: ', style: Theme.of(context).textTheme.labelLarge,),
                          Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                              return Text(controller.productCount.toString());
                            }
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
      
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              controller.gotoAddProducts(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  color: Color(0xffE1F4F0),
                                  borderRadius: BorderRadius.circular(16)),
                              height: size!.height / 5.8,
                              width: size.height / 5.8,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: size!.width / 6,
                                      width: size!.width / 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff2FDDB8),
                                      ),
                                      child: Center(
                                        child: Assets.icons.appProducts.svg(),
                                      ),
                                    ),
                                    Text('Add Product')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.gotoMakeSales(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  color: Color(0xffDBF8FF),
                                  borderRadius: BorderRadius.circular(16)),
                              height: size!.height / 5.8,
                              width: size.height / 5.8,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.gotoForecast(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  color: Color(0xffFEE3E8),
                                  borderRadius: BorderRadius.circular(16)),
                              height: size!.height / 5.8,
                              width: size.height / 5.8,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: size!.width / 6,
                                      width: size!.width / 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFE5171),
                                      ),
                                      child: Center(
                                        child: Assets.icons.sales.svg(),
                                      ),
                                    ),
                                    Text('Forecast')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.gotosalesHistory(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  // color: Colors.blue,
                                  color: Color(0xffFEE3E8),
                                  borderRadius: BorderRadius.circular(16)),
                              height: size!.height / 5.8,
                              width: size.height / 5.8,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: size!.width / 6,
                                      width: size!.width / 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFE5171),
                                      ),
                                      child: Center(
                                        child: Assets.icons.sales.svg(),
                                      ),
                                    ),
                                    Text('Sales History')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
