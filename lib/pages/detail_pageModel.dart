/*
import 'package:flutter/material.dart';
import 'package:ftapp/models/detail.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> course;
  List<Chapter> course = [];
  bool isLoading = true;
  final numberFormat = NumberFormat('#,###')

  void _getData(int id) async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/$id');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Detail detail = Detail.fromJson(convert.jsonDecode(response.body));
      setState(() {
        chapter = detail.chapter;
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
    Future.delayed(Duration.zero, () {    
      _getData(course['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(course['tittle']),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.separated(
        itemCount: course.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(chapter[index].chTitle),
            subtitle: Text(chapter[index].chDateadd),
            trailing: Chip(
              label: Text('${numberFormat.format(chapter[index].chView)}')
              backgroundColor: Colors.purpleAccent,
              ),
            );
        },
      ),
    );
  }
}
*/
