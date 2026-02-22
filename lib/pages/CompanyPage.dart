import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompantPageState();
}

class _CompantPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Company')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/company.jpg'),
              fit: BoxFit.cover,
            ),
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
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here',
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.phone_iphone),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('คณะบริหารธุระกิจ มทร.พระนคร'),
                            Text('0-2665-3555  ต่อ 2101-3'),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Wrap(
                      spacing: 8,
                      children: List.generate(
                        7,
                        (index) => Chip(
                          label: Text('text ${index + 1}'),
                          avatar: Icon(Icons.star),
                          backgroundColor: Colors.purple[300],
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 40,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
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

Image buliderHeader() {
  return Image(
    image: AssetImage('assets/images/company.jpg'),
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
        backgroundColor: Colors.purpleAccent,
      ),
    ),
  );
}
