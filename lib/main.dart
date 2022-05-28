import 'package:flutter/material.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop do John',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
          secondary: Colors.deepOrange,
        ),
        fontFamily: 'Lato',
      ),
      routes: {
        AppRoutes.kProductDetail: (context) => const ProductDetailPage(),
      },
      home: ProductsOverviewPage(),
    );
  }
}
