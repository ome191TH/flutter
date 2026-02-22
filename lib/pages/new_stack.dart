
import 'package:bwnp/pages/webview_page.dart';
import 'package:flutter/material.dart';

// import 'package:metmet/pages/detail_page.dart';
// import 'package:metmet/pages/product_page.dart';

class NewsStack extends StatefulWidget {
  const NewsStack({super.key});

  @override
  State<NewsStack> createState() => NewsStackState();
}

class NewsStackState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'Newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'Newsstack/news':
            builder = (BuildContext context) => const NewsStack();
            break;
          case 'Newsstack/webview':
            builder = (BuildContext context) => const WebViewPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
