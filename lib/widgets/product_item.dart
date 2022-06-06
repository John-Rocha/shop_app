import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/exceptions/http_exception.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/utils/app_constants.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      subtitle: Text(product.price.toStringAsFixed(2)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppConstants.kProductForm,
                  arguments: product,
                );
              },
              icon: const Icon(Icons.edit, color: Colors.purple),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text('Quer remover o produto?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).removeProduct(product);
                    } on HttpException catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
