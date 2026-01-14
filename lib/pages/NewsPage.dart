import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ftapp/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResult = 0;
  bool isLoading = true;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int page = 1;
  int pageSize = 5;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length + 1).toString());
    if (mounted)
      setState(() {
        ++page;
      });
    _getData();
    _refreshController.loadComplete();
  }

  void _getData() async {
    var url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=ab0d4aca4cea481e8157d31c68eb2b23&page=$page&pageSize=$pageSize',
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
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(height: 55.0, child: Center(child: body));
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
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
                                      ? Ink.image(
                                          image: NetworkImage(
                                            articles[index]['urlToImage'],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/no_image.png',
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
            ),
    );
  }
}
