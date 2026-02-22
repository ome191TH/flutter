import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    //return FlutterLogo(size: 50);
    return Image.asset('assets/images/C.png', height: 80, fit: BoxFit.cover);
  }
}
