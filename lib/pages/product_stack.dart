import 'package:bwnp/pages/detail_page.dart';
import 'package:flutter/material.dart';
// import 'package:metmet/pages/detail_page.dart';
// import 'package:metmet/pages/product_page.dart';

import 'product_page.dart';

class ProductStack extends StatefulWidget {
  const ProductStack({super.key});

  @override
  State<ProductStack> createState() => _ProductStackState();
}

class _ProductStackState extends State<ProductStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'productstack/product',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'productstack/product':
            builder = (BuildContext context) => const ProductPage();
            break;
          case 'productstack/detail':
            builder = (BuildContext context) => const DetailPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
