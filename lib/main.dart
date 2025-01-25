import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/db/db_helper.dart';
import 'package:inv_management_app/features/dashboard/provider/dashboard_controller.dart';
import 'package:inv_management_app/features/forecast_dir/provider/forecast_controller.dart';
import 'package:inv_management_app/features/home/provider/home_controller.dart';
import 'package:inv_management_app/features/productList_dir/provider/product_list_controller.dart';
import 'package:inv_management_app/network/network_client.dart';
import 'package:inv_management_app/services/db_service.dart';
import 'package:provider/provider.dart';

import 'features/add_product/provider/addproduct_controller.dart';
import 'features/dashboard/view/dashboard_screen.dart';
import 'features/sale_dir/provider/sales_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
        ChangeNotifierProvider(create: (_) => ForecastController()),
        ChangeNotifierProvider(
            create: (_) => HomeProvider(
                  service: ProductService(DatabaseHelper()),
                  dbHelper: DatabaseHelper(),
                )),
        ChangeNotifierProvider(
          create: (_) => ProductListProvider(
            ProductService(
              DatabaseHelper(),
            ),
            NetworkService()
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddProductProvider(
            service: ProductService(DatabaseHelper()),
            dbHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return MaterialApp(
      title: 'Inventory App',
      debugShowCheckedModeBanner: false,
      theme: themeModel.isDarkMode ? themeModel.darkTheme : themeModel.lightTheme,
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return DashboardScreen();
  }
}
