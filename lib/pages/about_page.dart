import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<Map<String, dynamic>> _getData() async {
    var url = Uri.parse('https://api.codingthailand.com/api/version');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      return data;
    } else {
      //error 400,500
      //print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load albums');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final fullname =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('เกี่ยวกับเรา'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!['data']['version']);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            Text('ชื่อ - นามสกุล : ${fullname['name']} ${fullname['surname']}'),
            const Text('BUS RMUTP'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homestack/contact');
              },
              child: Text("ติดต่อเรา"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {'page': 'about', 'msg': 'hello'});
              },
              child: Text("กลับหน้าหลัก"),
            ),
          ],
        ),
      ),
    );
  }
}
