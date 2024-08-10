import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    Myapp(),
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  String? data;
  var news;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://inshortsapi.vercel.app/news?category=entertainment"));

    if (response.statusCode == 200) {
      data = response.body;
      setState(() {
        news = jsonDecode(data!)['data'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS APP"),
      ),
      body: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(news[index]['title']),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(news[index]['content']),
                ),
                Image.network(
                  news[index]['imageUrl'],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                  alignment: Alignment.center,
                )
              ]),
            );
          }),
    );
  }
}
