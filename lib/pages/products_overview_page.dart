import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        centerTitle: true,
      ),
      body: const ProductGrid(),
    );
  }
}
