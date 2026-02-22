
import 'package:bwnp/pages/CompanyPage.dart';
import 'package:bwnp/pages/UpdateProfilePage.dart';
import 'package:bwnp/pages/about_page.dart';
import 'package:bwnp/pages/contact_page.dart';
import 'package:bwnp/pages/home_page.dart';
import 'package:bwnp/pages/room_page.dart';
import 'package:flutter/material.dart';

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
            builder = (BuildContext context) => const Homepage();
            break;
          case 'homestack/about':
            builder = (BuildContext context) => const AboutPage();
            break;
          case 'homestack/contact':
            builder = (BuildContext context) => const ContactPage();
            break;
          case 'homestack/company':
            builder = (BuildContext context) => const CompanyPage();
            break;
          case 'homestack/room':
            builder = (BuildContext context) => const Roompage();
            break;
          case 'homestack/updateprofile':
            builder = (BuildContext context) => const UpdateProfilePage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}
