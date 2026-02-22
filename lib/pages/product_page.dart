import 'package:bwnp/redux/AppReducer.dart';
import 'package:bwnp/redux/product/ProductAction.dart';
import 'package:bwnp/redux/product/ProductReducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:metmet/widgets/menu.dart';
//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;

import '../widgets/menu.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //List<dynamic> course = [];
  //bool isLoading = true;

  //void _getData() async {
  /*var url = Uri.https('api.codingthailand.com', '/api/course');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body);
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');
      Map<String, dynamic> product = convert.jsonDecode(response.body);
      setState(() {
        course = product['data'];
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }*/
  //}

  void _getData() async {
    final store = StoreProvider.of<AppState>(context, listen: false);
    await store.dispatch(gtProductAction(store));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
    _getData();
    });
    //_getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Product')),
      drawer: Menu(),
      body: StoreConnector<AppState, ProductState>(
        distinct: true,
        converter: (store) => store.state.productState,
        builder: (context, productState) {
          return productState.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: productState.course.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage(
                              productState.course[index]['picture'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(productState.course[index]['title']),
                      subtitle: Text(productState.course[index]['detail']),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'productstack/detail',
                          arguments: {
                            'id': productState.course[index]['id'],
                            'title': productState.course[index]['title'],
                          },
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
