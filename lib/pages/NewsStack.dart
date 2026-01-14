import 'package:flutter/material.dart';
import 'package:ftapp/pages/NewsPage.dart';
import 'package:ftapp/pages/WebViewPage.dart';

class NewsStack extends StatefulWidget {
  const NewsStack({super.key});

  @override
  State<NewsStack> createState() => _NewsStackState();
}

class _NewsStackState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newsstack/news':
            builder = (BuildContext context) => const NewsPage();
            break;
          case 'newsstack/webview':
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
