import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:easy_search/easy_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Easy Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Simple Offline
            EasySearch(
              multipleSelect: true,
              searchResultSettings: SearchResultSettings(padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0)),
              controller: SearchItem(
                items: [
                  Item(ModelExample(name: 'Tiago', age: 36), false),
                  Item(ModelExample(name: 'Mel', age: 3), true),
                  Item(ModelExample(name: 'Monique', age: 30), false),
                ],
              ),
            ),
            SizedBox(height: 20),

            //Dio request
            EasySearch(
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              multipleSelect: true,
              searchResultSettings: SearchResultSettings(padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0)),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ModelExample>> getData({name}) async {
    var response = await Dio().get(
      "https://5f24717b3b9d35001620456b.mockapi.io/user",
      queryParameters: {"name": name},
    );

    var result = ModelExample.fromJsonList(response.data);
    return result;
  }
}

class ModelExample {
  final String name;
  final int age;

  ModelExample({this.name, this.age});

  @override
  String toString() {
    return '$name $age';
  }

  factory ModelExample.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ModelExample(
      name: json["name"],
      age: json["age"],
    );
  }

  static List<ModelExample> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ModelExample.fromJson(item)).toList();
  }

  @override
  operator ==(o) => o is ModelExample || this.name.toLowerCase().contains(o.toString().toLowerCase());

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
