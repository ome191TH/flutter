import 'dart:convert' as convert;

import 'package:bwnp/redux/AppReducer.dart';
import 'package:bwnp/redux/product/ProductReducer.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';


@immutable
class GetProductAction {
  // แนะนำให้ใช้ชื่อ products เพื่อสื่อความหมายว่าเป็นรายการสินค้า
  final ProductState productState;

  GetProductAction(this.productState);
}

gtProductAction(Store<AppState> store) async {
  try {
    var url = Uri.https('api.codingthailand.com', '/api/course');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body);
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');
      final Map<String, dynamic> product = convert.jsonDecode(response.body);
      /*setState(() {
        course = product['data'];
        isLoading = false;
      });*/
      store.dispatch(
        GetProductAction(
          ProductState(course: product['data'], isLoading: false),
        ),
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');
      store.dispatch(
        GetProductAction(ProductState(course: [], isLoading: false)),
      );
    }
  } catch (e) {
    print(e);
    store.dispatch(
      GetProductAction(ProductState(course: [], isLoading: false)),
    );
  }
  //return product ;
}
