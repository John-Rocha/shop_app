import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/exceptions/http_exception.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/utils/app_constants.dart';

class ProductProvider with ChangeNotifier {
  String _token;
  List<Product> _items = [];
  bool _showFavoriteOnly = false;

  ProductProvider(this._token, this._items);

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite == true).toList();
    }
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response =
        await http.get(Uri.parse('${AppConstants.kBaseUrl}.json?auth=$_token'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${AppConstants.kBaseUrl}.json'),
      body: jsonEncode(
        {
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${AppConstants.kBaseUrl}/${product.id}.json'),
        body: jsonEncode(
          {
            'name': product.name,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${AppConstants.kBaseUrl}/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          message: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
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
