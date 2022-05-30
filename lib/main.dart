import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/utils/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop do John',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
            accentColor: Colors.purpleAccent,
            primaryColorDark: const Color(0XFFc0b3c2),
            backgroundColor: const Color(0xFFf3e5f5),
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        initialRoute: AppRoutes.kHome,
        routes: {
          AppRoutes.kProductDetail: (context) => const ProductDetailPage(),
          AppRoutes.kCartPage: (context) => const CartPage(),
          AppRoutes.kHome: (context) => const ProductsOverviewPage(),
          AppRoutes.kOrders: (context) => const OrdersPage(),
        },
        // home: const ProductsOverviewPage(),
      ),
    );
  }
}
