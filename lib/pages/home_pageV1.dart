import 'package:flutter/material.dart';
import 'package:ftapp/widgets/logo.dart';
import 'package:ftapp/widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var returnData;
  Map<String, dynamic> data = {'page': '', 'msg': ''};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Logo(),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: const Menu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('Message is ${data['msg']} from ${data['page']}'),
            ElevatedButton(
              onPressed: () async{
                returnData = await Navigator.pushNamed(context, 'homestack/about', 
                arguments: <String, String>{
                  'name': 'Suttikan',
                  'surname': 'Srimara'
                }
                );
                setState(() {
                  if (returnData != null) {
                    data = returnData;
                  }
                });
            }, 
            child: Text("เกี่ยวกับเรา")
            ),
          ],
        ),
      ),
    );
  }
}