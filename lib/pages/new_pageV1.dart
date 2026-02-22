import 'package:bwnp/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResult = 0;
  bool isLoading = true;

  void _getData() async {
    var url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=ab0d4aca4cea481e8157d31c68eb2b23',
    );

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> news = convert.jsonDecode(response.body);
      setState(() {
        totalResult = news['totalResults'];
        articles = news['articles'];
        //room = hotel ?? [];
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
        backgroundColor: Colors.orangeAccent,
        title: totalResult > 0 ? Text("ข่าวทั้งหมด $totalResult ข่าว") : null,
      ),
      drawer: Menu(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: articles.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'newsstack/webview',
                        arguments: {'news': articles[index]},
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: articles[index]['urlToImage'] != null
                                    ? Image.network(
                                        articles[index]['urlToImage'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/no_pic.png',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                      )
                                    : Image.asset(
                                        'assets/images/no_pic.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${articles[index]['source']['name']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${articles[index]['title']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  articles[index]['author'] != null
                                      ? Flexible(
                                          child: Chip(
                                            avatar: Icon(
                                              Icons.person,
                                              size: 18,
                                            ),
                                            label: Text(
                                              articles[index]['author']
                                                          .toString()
                                                          .length >
                                                      20
                                                  ? '${articles[index]['author'].toString().substring(0, 20)}'
                                                  : '${articles[index]['author']}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Spacer(),
                                  Text(
                                    '${articles[index]['publishedAt']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
