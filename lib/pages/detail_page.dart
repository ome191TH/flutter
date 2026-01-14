import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map<String, dynamic> course;
  List<dynamic> chapter = [];
  bool isLoading = true;
  final numberFormat = NumberFormat('#,###');

  void _getData(int id) async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/$id');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> detail = convert.jsonDecode(response.body);
      setState(() {
        chapter = detail['data'];
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
    course = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(course['title']),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: chapter.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${chapter[index]['ch_title']}'),
                  subtitle: Text('${chapter[index]['ch_dateadd']}'),
                  trailing: Chip(
                    label: Text(
                      '${numberFormat.format(chapter[index]['ch_view'])}',
                    ),
                    backgroundColor: Colors.purpleAccent,
                  ),
                );
              },
            ),
    );
  }
}
