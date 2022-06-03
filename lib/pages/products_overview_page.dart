import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/utils/app_routes.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/cart_badge.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        centerTitle: true,
        actions: [
          Provider.of<ProductProvider>(context).menu(context, product),
          Consumer<CartProvider>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.kCartPage);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cartItem, child) => CartBadge(
              value: cartItem.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: const ProductGrid(),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const AppDrawer(),
    );
  }
}
