import 'package:flutter/material.dart';
import 'package:ftapp/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> course = [];
  bool isLoading = true;
  void _getData() async {
    var url = Uri.parse('https://api.codingthailand.com/api/course');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> product = (convert.jsonDecode(response.body));
      setState(() {
        course = product['data'];
        isLoading = false;
      });
    } else {
      //error 400,500
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const Menu(),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.separated(
        itemCount: course.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.rectangle,image: DecorationImage(image: NetworkImage(course[index]['picture']),fit: BoxFit.cover)),),
            title: Text(course[index]['title']),
            subtitle: Text(course[index]['detail']),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, 'productstack/detail', arguments: {
                'id' : course[index]['id'],
                'title' : course[index]['title'],
              });
            },
            );
        },
      ),
    );
  }
}
