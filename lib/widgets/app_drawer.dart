import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/utils/app_constants.dart';
import 'package:shop_app/utils/custom_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo usuário'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppConstants.kAuthOrHome,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppConstants.kOrders,
              );
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (context) => const OrdersPage(),
              //   ),
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciador de Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppConstants.kProducts,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).logout();

              Navigator.of(context).pushReplacementNamed(
                AppConstants.kAuthOrHome,
              );
            },
          ),
        ],
      ),
    );
  }
}
