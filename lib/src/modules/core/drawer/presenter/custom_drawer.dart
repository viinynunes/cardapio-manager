import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Stack(
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text('Nunes'),
                  accountEmail: Text('nunes@outlook.com'),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Modular.to.pushReplacementNamed('../auth/');
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/order/');
              },
              leading: const Icon(Icons.reorder),
              title: const Center(child: Text('Pedidos')),
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/');
              },
              leading: const Icon(Icons.menu_book),
              title: const Center(child: Text('Menu')),
            ),
            ListTile(
              onTap: () {
                Modular.to.pop();
                Modular.to.navigate('/client/');
              },
              leading: const Icon(Icons.account_circle),
              title: const Center(child: Text('Clientes')),
            ),
          ],
        ),
      ),
    );
  }
}
