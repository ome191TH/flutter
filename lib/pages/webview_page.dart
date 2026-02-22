import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // สร้าง controller พร้อมตั้งค่า URL
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)?.settings.arguments as Map?;

    final url = news?['articles']?['url'] ?? '';
    _controller.loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${news?['articles']?['source']?['name'] ?? ''}'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
