//import 'package:ftapp/pages/about_page.dart';
//import 'package:ftapp/pages/contact_page.dart';
//import 'package:ftapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ftapp/pages/NewsStack.dart';
import 'package:ftapp/pages/RegisterPage.dart';
import 'package:ftapp/pages/home_stack.dart';
import 'package:ftapp/pages/product_stack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch:  Color.fromARGB(255, 97, 52, 105),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orangeAccent),
        canvasColor: Colors.green[100],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      //home: const HomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const RegisterPage(),
        '/home': (BuildContext context) => const HomeStack(),
        '/product': (BuildContext context) => const ProductStack(),
        '/newsstack': (BuildContext context) => const NewsStack(),
        //'/': (BuildContext context) =>  const HomePage(),
        //'/about': (BuildContext context) =>  const AboutPage(),
        //'/contact': (BuildContext context) =>  const ContactPage(),
      },
    );
  }
}
