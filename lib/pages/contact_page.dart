import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('ติดต่อเรา'),
          automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ติดต่อเรา'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,);

              }, 
              child: Text('กลับหน้าเกี่ยวกับเรา')
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, 'homestack/home', (route) => false);

              }, 
              child: Text('กลับหน้าหลัก')
            ),
          ],
        ),
      ),
    );
  }
}