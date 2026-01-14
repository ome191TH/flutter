import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'RMUTP';

  void _changeCompanyName(){
    setState(() {
      companyName = 'Bus RMUTP';
    });
  }

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('init state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(companyName),
        ElevatedButton(
          onPressed: _changeCompanyName, 
          child: const Text('Click Me!!!')
        )
      ],
    );
  }
}