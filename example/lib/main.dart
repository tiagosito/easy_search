import 'package:dio/dio.dart';
import 'package:easy_search/easy_search.dart';
import 'package:flutter/material.dart';

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
  SearchItem controllerStartWithValue = SearchItem(
    items: [
      Item(ModelExample(name: 'Tiago', age: 37), true),
      Item(ModelExample(name: 'Mel', age: 3), false),
      Item(ModelExample(name: 'Monique', age: 30), false),
      Item(ModelExample(name: 'Timothy', age: 0), false),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInformation(information: 'Simple Offline List'),
            EasySearch(
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              onChange: (value) {
                print(value.length);
              },
              controller: SearchItem(
                items: [
                  Item(ModelExample(name: 'Tiago', age: 36), false),
                  Item(ModelExample(name: 'Mel', age: 3), false),
                  Item(ModelExample(name: 'Monique', age: 30), false),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'Simple Offline List\nWith Custom Layout'),
            EasySearch(
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              controller: SearchItem(
                items: [
                  Item(ModelExample(name: 'Tiago', age: 36), false),
                  Item(ModelExample(name: 'Mel', age: 3), false),
                  Item(ModelExample(name: 'Monique', age: 30), false),
                ],
              ),
              customItemBuilder: (BuildContext context, ModelExample item, bool isSelected) {
                return Container(
                  decoration: !isSelected
                      ? null
                      : BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(item.name),
                    subtitle: Text(
                      item.age.toString(),
                    ),
                    leading: Icon(Icons.people),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'Simple Offline List\nWith Custom Layout\nMulti Select Items'),
            EasySearch(
              multipleSelect: true,
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              onChange: (value) {
                print(value.length);
              },
              controller: SearchItem(
                items: [
                  Item(ModelExample(name: 'Tiago', age: 36), false),
                  Item(ModelExample(name: 'Mel', age: 3), false),
                  Item(ModelExample(name: 'Monique', age: 30), false),
                ],
              ),
              customItemBuilder: (BuildContext context, ModelExample item, bool isSelected) {
                return Container(
                  decoration: !isSelected
                      ? null
                      : BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(item.name),
                    subtitle: Text(item.age.toString()),
                    leading: Icon(Icons.people),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'Start controller with value\nand With data from HTTP Request'),
            EasySearch(
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              startWithValue: true,
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              filterPageSettings: FilterPageSettings(
                searchOnShow: false,
              ),
              controller: SearchItem(
                items: [
                  Item(ModelExample(name: 'Tiago', age: 37), true),
                  Item(ModelExample(name: 'Mel', age: 3), false),
                  Item(ModelExample(name: 'Monique', age: 30), false),
                  Item(ModelExample(name: 'Timothy', age: 0), false),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'With data from HTTP Request'),
            EasySearch(
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'With data from HTTP Request\nWith Custom Layout'),
            EasySearch(
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              customItemBuilder: (BuildContext context, ModelExample item, bool isSelected) {
                return Container(
                  decoration: !isSelected
                      ? null
                      : BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(item.name),
                    subtitle: Text(item.age.toString()),
                    leading: Icon(Icons.people),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'With data from HTTP Request\nWith Custom Layout\nMulti Select Items'),
            EasySearch(
              multipleSelect: true,
              onChange: (value) {
                print(value?.length);
              },
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              customItemBuilder: (BuildContext context, ModelExample item, bool isSelected) {
                return Container(
                  decoration: !isSelected
                      ? null
                      : BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                  child: ListTile(
                    selected: isSelected,
                    title: Text(item.name),
                    subtitle: Text(item.age.toString()),
                    leading: Icon(Icons.people),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            buildInformation(information: 'Programmatically change the list of items'),
            EasySearch(
              onSearch: (text) {
                print('Filter Query: $text');
                return getData(name: text);
              },
              startWithValue: true,
              searchResultSettings: SearchResultSettings(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                label: LabelSettings.searchLabel(value: 'People'),
              ),
              filterPageSettings: FilterPageSettings(
                searchOnShow: false,
              ),
              controller: controllerStartWithValue,
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  //1ª Create the new listToFill
                  List<Item<ModelExample>> listToFill = [
                    Item(ModelExample(name: 'ABC 123', age: 3), true),
                    Item(ModelExample(name: 'ACB 132', age: 13), false),
                    Item(ModelExample(name: 'BAC 213', age: 23), false),
                    Item(ModelExample(name: 'BCA 231', age: 33), false),
                    Item(ModelExample(name: 'CAB 312', age: 43), false),
                    Item(ModelExample(name: 'CBA 321', age: 53), false),
                  ];

                  //2ª Update controller with new listToFill
                  controllerStartWithValue.changingValues(listToFill);
                },
                child: Text('Changing list'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInformation({String information}) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 0),
          child: Center(
            child: Text(
              information,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
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
  operator ==(object) => this.name.toLowerCase().contains(object.toLowerCase()) || this.age.toString().contains(object);

  // @override
  // operator ==(o) =>
  //     o is ModelExample && this.name.toLowerCase().contains(o.name.toLowerCase()); // && this.hashCode == o.hashCode;

  // @override
  // operator ==(o) =>
  //     o is ModelExample &&
  //     (this.name.toLowerCase().contains(o.name.toLowerCase()) || this.age.toString().contains(o.age.toString()));

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
