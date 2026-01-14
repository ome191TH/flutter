import 'package:flutter/material.dart';

class Companypage extends StatefulWidget {
  const Companypage({super.key});

  @override
  State<Companypage> createState() => _CompanypageState();
}

class _CompanypageState extends State<Companypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Company')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            builderHeader(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'RMUTP',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.phone_iphone, size: 30),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('คณะบริหารธุรกิจ มทร.พระนคร'),
                            Text('0-2665-3555 ต่อ 2101-3'),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    builderWrap(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/User.png'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/User.png'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/User.png'),
                          radius: 40,
                        ),
                        SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(Icons.access_alarm),
                              Icon(Icons.accessibility),
                              Icon(Icons.account_balance),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Image builderHeader() {
  return Image(
    image: AssetImage('assets/images/company.png'),
    fit: BoxFit.cover,
  );
}

Wrap builderWrap() {
  return Wrap(
    spacing: 8,
    children: List.generate(
      7,
      (index) => Chip(
        label: Text('text ${index + 1}'),
        avatar: Icon(Icons.star),
        backgroundColor: Colors.purple[300],
      ),
    ),
  );
}
