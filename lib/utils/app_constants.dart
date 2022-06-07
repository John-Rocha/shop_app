import 'package:flutter/cupertino.dart';
import 'package:shop_app/pages/auth/auth_or_home_page.dart';
import 'package:shop_app/pages/auth/auth_page.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/product_form_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/pages/products_page.dart';

class AppConstants {
  static const kAuthOrHome = '/';
  static const kAuth = '/auth';
  static const kHome = '/home';
  static const kProductDetail = '/product-detail';
  static const kCartPage = '/cart-page';
  static const kOrders = '/orders';
  static const kProducts = '/products';
  static const kProductForm = '/product-form';

  static Map<String, WidgetBuilder> routes = {
    kProductDetail: (context) => const ProductDetailPage(),
    kCartPage: (context) => const CartPage(),
    kOrders: (context) => const OrdersPage(),
    kProducts: (context) => const ProductsPage(),
    kProductForm: (context) => const ProductFormPage(),
    kAuth: (context) => const AuthPage(),
    kAuthOrHome: (context) => const AuthOrHomePage(),
  };

  // Url Firebase
  static const kBaseUrl =
      'https://shop-app-john-default-rtdb.firebaseio.com/products';
  static const kOrderBaseUrl =
      'https://shop-app-john-default-rtdb.firebaseio.com/orders';
}
