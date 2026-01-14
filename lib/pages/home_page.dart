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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: ()  {
                Navigator.pushNamed(context, 'homestack/company');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.business, size: 80, color: Colors.blue[800]),
                    const Text(
                      "Company",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.map, size: 80, color: Colors.blue[800]),
                  const Text(
                    "Map",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_enhance, size: 80, color: Colors.blue[800]),
                  const Text(
                    "Camera",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () async {
                returnData = await Navigator.pushNamed(
                  context,
                  'homestack/about',
                  arguments: <String, String>{
                    'name': 'Suttikan',
                    'surname': 'Srimara',
                  },
                );
                setState(() {
                  if (returnData != null) {
                    data = returnData;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, size: 80, color: Colors.blue[800]),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
                        GestureDetector(
              onTap: ()  {
                Navigator.pushNamed(context, 'homestack/room');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check_box_rounded, size: 80, color: Colors.blue[800]),
                    const Text(
                      "Room",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
