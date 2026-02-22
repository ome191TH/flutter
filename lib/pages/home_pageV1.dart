import 'package:bwnp/widgets/logo.dart';
import 'package:bwnp/widgets/menu.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // ignore: prefer_typing_uninitialized_variables
  var returnData;
  Map<String, dynamic> data = {'page': '', 'msg': ''};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Logo(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Menu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('Message is ${data['msg']} from ${data['page']}'),
            ElevatedButton(
              onPressed: () async {
                returnData = await Navigator.pushNamed(
                  context,
                  'homestack/about',
                  arguments: <String, String>{
                    'name': ' Suttikan',
                    'surname': 'Srimara',
                  },
                );
                setState(() {
                  if (returnData != null) {
                    data = returnData;
                  }
                });
              },
              child: const Text('เกี่ยวกับเรา'),
            ),
          ],
        ),
      ),
    );
  }
}
