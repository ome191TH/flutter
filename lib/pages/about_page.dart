import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final fullname =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('เกียวกับเรา'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ชื่อ - นามสกุล : ${fullname['name']} ${fullname['surname']}'),
            Text('BUS RMUTP'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homestack/contact');
              },
              child: const Text('ติดต่อเรา'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {'page': 'about', 'msg': 'hello'});
              },
              child: const Text('กลับหน้าหลัก'),
            ),
          ],
        ),
      ),
    );
  }
}
