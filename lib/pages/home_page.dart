import 'package:bwnp/redux/AppReducer.dart';
import 'package:bwnp/redux/profile/ProfileAction.dart'; // เพิ่ม Action
import 'package:bwnp/redux/profile/ProfileReducer.dart';
import 'package:bwnp/widgets/logo.dart';
import 'package:bwnp/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart'; // สำหรับดึงค่าตอนเปิดแอป
import 'dart:convert' as convert;

// ... ส่วน import เหมือนเดิม ...

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            StoreConnector<AppState, ProfileState>(
              converter: (store) => store.state.profileState,
              builder: (context, profile) {
                return Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'ยินดีต้อนรับ ${profile.profile['name'] ?? 'Guest'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              flex: 9,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  // ปุ่ม Company
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, 'homestack/company'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.business,
                            size: 80,
                            color: Colors.blue[800],
                          ),
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
                  // ปุ่ม Map
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.map, size: 80, color: Colors.blue[800]),
                          const Text(
                            "Map",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ปุ่ม Camera
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.camera_enhance,
                            size: 80,
                            color: Colors.blue[800],
                          ),
                          const Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ปุ่ม About
                  GestureDetector(
                    onTap: () async {
                      returnData = await Navigator.pushNamed(
                        context,
                        'homestack/about',
                        arguments: <String, String>{
                          'name': 'Thammasit',
                          'surname': 'Kreekaew',
                        },
                      );
                      if (returnData != null) setState(() => data = returnData);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
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

                  // ปุ่ม Room
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'homestack/room'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.room_rounded,
                            size: 80,
                            color: Colors.blue[800],
                          ),
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
                  // ✅ เพิ่มปุ่ม Customer ตรงนี้
                  GestureDetector(
                    onTap: () => Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed('/customer'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.5,
                        ), // 2. ย้ายสีมาไว้ตรงนี้ (ห้ามไว้นอก decoration)
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // 3. ตรงนี้จะหายแดงทันที
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            size: 80,
                            color: Colors.blue[800],
                          ), // ใช้ไอคอนรูปคน
                          const Text(
                            "Customer",
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
          ],
        ),
      ),
    );
  }
}

/*import 'package:bwnp/redux/AppReducer.dart';
import 'package:bwnp/redux/profile/ProfileReducer.dart';
import 'package:bwnp/widgets/logo.dart';
import 'package:bwnp/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            StoreConnector<AppState, ProfileState>(
              converter: (store) => store.state.profileState,
              builder: (context, profile) {
                return Expanded(
                  flex: 1,
                  child: Center(
                    // สมมติว่าอยู่ใน builder ของ StoreConnector ที่รับ state มาแล้ว
                    child: Text(
                      'ยินดีต้อนรับ ${profile.profile['name'] ?? 'Guest'}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              flex: 9,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'homestack/company');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.business,
                            size: 80,
                            color: Colors.blue[800],
                          ),
                          Text(
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

                  /* */
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.map, size: 80, color: Colors.blue[800]),
                        Text(
                          "Map",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /* */
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_enhance,
                          size: 80,
                          color: Colors.blue[800],
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /* */
                  GestureDetector(
                    onTap: () async {
                      returnData = await Navigator.pushNamed(
                        context,
                        'homestack/about',
                        arguments: <String, String>{
                          'name': ' Thammasit',
                          'surname': 'Kreekaew',
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
                          Text(
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
                    onTap: () {
                      Navigator.pushNamed(context, 'homestack/room');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.room_rounded,
                            size: 80,
                            color: Colors.blue[800],
                          ),
                          Text(
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
          ],
        ),
      ),
    );
  }
}*/
