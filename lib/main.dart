import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/pages/auth/auth_page.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_form_page.dart';
import 'package:shop_app/pages/products_page.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/remote_config/custom_remote_config.dart';
import 'package:shop_app/utils/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await CustomRemoteConfig().initialize();

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
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
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
        initialRoute: AppConstants.kAuth,
        routes: {
          AppConstants.kProductDetail: (context) => const ProductDetailPage(),
          AppConstants.kCartPage: (context) => const CartPage(),
          AppConstants.kHome: (context) => const ProductsOverviewPage(),
          AppConstants.kOrders: (context) => const OrdersPage(),
          AppConstants.kProducts: (context) => const ProductsPage(),
          AppConstants.kProductForm: (context) => const ProductFormPage(),
          AppConstants.kAuth: (context) => const AuthPage(),
        },
        // home: const ProductsOverviewPage(),
      ),
    );
  }
}
