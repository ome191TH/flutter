import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              trailing: Icon(Icons.arrow_right),
              selected:
                  ModalRoute.of(context)?.settings.name == 'homestack/home'
                  ? true
                  : false,
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.all_out),
              title: const Text('Product'),
              selected:
                  ModalRoute.of(context)?.settings.name ==
                      'productstack/product'
                  ? true
                  : false,
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/product', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.all_out),
              title: const Text('News'),
              selected:
                  ModalRoute.of(context)?.settings.name == 'newsstack/news'
                  ? true
                  : false,
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/newsstack', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
