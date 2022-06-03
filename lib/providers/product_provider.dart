import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/utils/app_routes.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = dummyProductus;
  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite == true).toList();
    }
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    http
        .post(
          Uri.parse('${AppRoutes.kBaseUrl}/products.json'),
          body: jsonEncode(
            {
              'name': product.name,
              'price': product.price,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite,
            },
          ),
        )
        .then((value) {});

    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == product.id);
      notifyListeners();
    }
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Widget menu(BuildContext context, ProductProvider provider) {
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
}
