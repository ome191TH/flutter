/*
import 'package:flutter/material.dart';
import 'package:ftapp/models/Room.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Roompage extends StatefulWidget {
  const Roompage({super.key});

  @override
  State<Roompage> createState() => _RoompageState();
}

class _RoompageState extends State<Roompage> {

List<Room> room = [];
  bool isLoading = true;

  void _getData() async {
    var url = Uri.parse('https://bus.rmutp.ac.th/cis/flutter/get_rooms.php');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Hotel hotel = Hotel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        room = hotel.room ?? [];
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
        title: Text("ROOM"),
      ),   
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.separated(
        itemCount: room.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(room[index].name),
            subtitle: Text(room[index].status),
          );
        },
      ),
      );
  }
}
*/
