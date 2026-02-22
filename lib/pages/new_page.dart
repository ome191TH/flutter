import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../widgets/menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults = 0;
  bool isLoading = true;

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  int page = 1;
  final int pageSize = 5;

  Future<void> _getData({bool isRefresh = false}) async {
    var url = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': 'us',
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'apiKey': 'ab0d4aca4cea481e8157d31c68eb2b23',
    });

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> news = convert.jsonDecode(response.body);
        setState(() {
          totalResults = news['totalResults'];
          if (isRefresh) {
            articles = news['articles'];
          } else {
            articles.addAll(news['articles']);
          }
          isLoading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        if (isRefresh) {
          _refreshController.refreshFailed();
        } else {
          _refreshController.loadFailed();
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (isRefresh) {
        _refreshController.refreshFailed();
      } else {
        _refreshController.loadFailed();
      }
    }
  }

  void _onRefresh() async {
    page = 1;
    await _getData(isRefresh: true);
    _refreshController.refreshCompleted(); // หยุดหมุนตอนรีเฟรชเสร็จ
  }

  void _onLoading() async {
    if (articles.length >= totalResults) {
      _refreshController.loadNoData();
      return;
    }
    page++;
    await _getData();
    _refreshController.loadComplete();
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
        title: totalResults > 0 ? Text('ข่าวทั้งหมด $totalResults ข่าว') : null,
      ),
      drawer: Menu(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: ClassicHeader(
                refreshingText: '',
                idleText: '',
                completeText: '',
                releaseText: '',
                failedText: '',
                refreshingIcon: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;

                  switch (mode) {
                    case LoadStatus.idle:
                      body = Text("pull up load");
                      break;
                    case LoadStatus.loading:
                      body = CircularProgressIndicator();
                      break;
                    case LoadStatus.failed:
                      body = GestureDetector(
                        onTap: () {
                          _onLoading(); // โหลดใหม่
                        },
                        child: Text(
                          "Load Failed! Click retry!",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                      break;
                    case LoadStatus.canLoading:
                      body = Text("release to load more");
                      break;
                    case LoadStatus.noMore:
                      body = GestureDetector(
                        onTap: () {
                          _onRefresh();
                        },
                        child: Text(
                          "No more Data (Tap to refresh)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                      break;
                    default:
                      body = SizedBox.shrink();
                  }

                  return SizedBox(height: 55.0, child: Center(child: body));
                },
              ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                itemCount: articles.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final article = articles[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/newsstack/webview',
                          arguments: {'articles': article},
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
                                  child: article['urlToImage'] != null
                                      ? Image.network(
                                          article['urlToImage'],
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
                                      '${article['source']['name']}',
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
                                Text('${article['title']}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    article['author'] != null
                                        ? Chip(
                                            avatar: Icon(Icons.person),
                                            label: Text(
                                              article['author']
                                                          .toString()
                                                          .length <
                                                      20
                                                  ? '${article['author']}'
                                                  : '${article['author'].toString().substring(0, 20)}',
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Text('${article['publishedAt']}'),
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
