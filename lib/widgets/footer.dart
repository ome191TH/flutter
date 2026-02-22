import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'RMUTP';

  void _changecompanyName() {
    setState(() {
      companyName = 'BUS RMUTP';
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(companyName),
        ElevatedButton(
          onPressed: _changecompanyName,
          child: Text('Click Me!!!'),
        ),
      ],
    );
  }
}
