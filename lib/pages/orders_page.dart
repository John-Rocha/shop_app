import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  Future<void> _refreshOrders(BuildContext context) async {
    Provider.of<OrderProvider>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(
          context,
          listen: false,
        ).loadOrders(),
        builder: (context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<OrderProvider>(
              builder: (context, orders, _) => RefreshIndicator(
                onRefresh: () => _refreshOrders(context),
                child: ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (context, index) =>
                      OrderWidget(order: orders.items[index]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
