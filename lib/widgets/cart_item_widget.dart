import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${cart.price}'),
              ),
            )),
        title: Text(cart.name),
        subtitle: Text(
            'Total: R\$ ${(cart.price * cart.quantity).toStringAsFixed(2)}'),
        trailing: Text('${cart.quantity}x'),
      ),
    );
  }
}
