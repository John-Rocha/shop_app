import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductProvider products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Text(products.items[index].name),
        ),
      ),
    );
  }
}
