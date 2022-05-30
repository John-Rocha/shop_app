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
          _menu(context, product),
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

Widget _menu(BuildContext context, ProductProvider provider) {
  return PopupMenuButton(
    icon: const Icon(Icons.more_horiz_outlined),
    color: Theme.of(context).colorScheme.background,
    itemBuilder: (context) => [
      const PopupMenuItem(
        value: FilterOptions.favorite,
        child: Text('Somente Favoritas'),
      ),
      const PopupMenuItem(
        value: FilterOptions.all,
        child: Text('Todos'),
      ),
    ],
    onSelected: (FilterOptions selectedValue) {
      if (selectedValue == FilterOptions.favorite) {
        provider.showFavoriteOnly();
      } else {
        provider.showAll();
      }
    },
  );
}
