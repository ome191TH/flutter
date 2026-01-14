import 'package:flutter/material.dart';
import 'package:ftapp/pages/CompanyPage.dart';
import 'package:ftapp/pages/RoomPage.dart';
import 'package:ftapp/pages/about_page.dart';
import 'package:ftapp/pages/contact_page.dart';
import 'package:ftapp/pages/home_page.dart';

class HomeStack extends StatefulWidget {
  const HomeStack({super.key});

  @override
  State<HomeStack> createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder = (BuildContext context) => const HomePage();
            break;
          case 'homestack/about':
            builder = (BuildContext context) => const AboutPage();
            break;
          case 'homestack/contact':
            builder = (BuildContext context) => const ContactPage();
            break;

          case 'homestack/company':
            builder = (BuildContext context) => const Companypage();
            break;

          case 'homestack/room':
            builder = (BuildContext context) => const Roompage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
