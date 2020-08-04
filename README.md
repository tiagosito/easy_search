
<img src="https://github.com/tiagosito/easy_search/raw/master/doc/assets/easy_search_logo_full.png" width="100%" alt="logo" />
<h2 align="center">
  A highly customizable search component to accelerate your development.
</h2>

<p align="center">
<a href="https://pub.dartlang.org/packages/easy_search">
  <img alt="Pub Package" src="https://img.shields.io/pub/v/easy_search.svg">
</a>
  <a href="https://www.buymeacoffee.com/tiagosito" target="_blank"><img alt="Buy Me A Coffee" src="https://i.imgur.com/aV6DDA7.png" </a>
</p>
 
  
## Overview

There are many search or search components for `Flutter`, however this one comes to perform search in `Offline List`,

or `HTTP Search` and more, it already comes with nice default layout and many customizations,

and we can focus more on writing amazing applications.

- **[Getting Started](#getting-started)**
- [Important configuration](#important-configuration)
 - [How to use Offline list (Local)](#offline-list)
   - [Default Layout](#default-layout)
   - [Custom Layout](#custom-layout)
   - [Multi Select Items](#multi-select-items)
 - [How to use From Server (HTTP Request)](#http-request)
   - [Default Layout](#default-layout---http)
   - [Default Layout](#custom-layout---http)
   - [Multi Select Items](#multi-select-items---http)
 - [Important About Models](#important-about-models)
 - [Roadmap](#roadmap)


#### Contributing
  - [https://github.com/tiagosito/easy_search](https://github.com/tiagosito/easy_search)


#### Getting Started


In _pubspec.yaml_:
```yaml
dependencies:
  easy_search: any
```


### Important configuration:
  * If you want to use the Offline List or Local list, do not implement the OnSearch method

 * If you want to fetch data from a web server or an API, do not implement the Offline List or Local List

 * #### If both OnSearch and the Offline List are implemented, the OnSearch method will prevail and the Offline List will be ignored

### Offline list:

#### Default Layout:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/simple_offline_list.gif?raw=true" width="49%" alt="Simple Offline List" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
  searchResultSettings: SearchResultSettings(
    padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
  ),
  controller: SearchItem(
    items: [
      Item(ModelExample(name: 'Tiago', age: 36), false),
      Item(ModelExample(name: 'Mel', age: 3), false),
      Item(ModelExample(name: 'Monique', age: 30), false),
    ],
  ),
),
```

##### Custom Layout:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/simple_offline_list_with_custom_layout.gif" width="49%" alt="Simple Offline List With Custom Layout" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
  searchResultSettings: SearchResultSettings(
    padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
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
```

##### Multi Select Items:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/simple_offline_list_with_custom_layout_multi_select_items.gif" width="49%" alt="Simple Offline List With Custom Layout And Multi Selection Items" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
  multipleSelect: true,
  searchResultSettings: SearchResultSettings(padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0)),
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
```

### HTTP Request:

##### Default Layout - Http:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/from_http_request.gif" width="49%" alt="From HTTP Request" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
  onSearch: (text) {
    print('Filter Query: $text');
    return getData(name: text);
  },
  searchResultSettings: SearchResultSettings(
    padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
  ),
),

.
.
.

//HTTP request Example
Future<List<ModelExample>> getData({name}) async {
  var response = await Dio().get(
    "https://5f24717b3b9d35001620456b.mockapi.io/user",
    queryParameters: {"name": name},
  );

  var result = ModelExample.fromJsonList(response.data);
  return result;
}
```
##### Custom Layout - Http:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/from_http_request_with_custom_layout.gif" width="49%" alt="From HTTP Request With Custom Layout" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
onSearch: (text) {
  print('Filter Query: $text');
  return getData(name: text);
},
searchResultSettings: SearchResultSettings(
  padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
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

.
.
.

//HTTP request Example
Future<List<ModelExample>> getData({name}) async {
  var response = await Dio().get(
    "https://5f24717b3b9d35001620456b.mockapi.io/user",
    queryParameters: {"name": name},
  );

  var result = ModelExample.fromJsonList(response.data);
  return result;
}
```

##### Multi Select Items - Http:
<img src="https://github.com/tiagosito/easy_search/blob/master/doc/assets/from_http_request_with_custom_layout_multi_select_items.gif" width="49%" alt="From HTTP Request With Custom Layout And Multi Select Items" />

```dart
import 'package:easy_search/easy_search.dart';

EasySearch(
multipleSelect: true,
onSearch: (text) {
  print('Filter Query: $text');
  return getData(name: text);
},
searchResultSettings: SearchResultSettings(
  padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
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

.
.
.

//HTTP request Example
Future<List<ModelExample>> getData({name}) async {
  var response = await Dio().get(
    "https://5f24717b3b9d35001620456b.mockapi.io/user",
    queryParameters: {"name": name},
  );

  var result = ModelExample.fromJsonList(response.data);
  return result;
}
```
### Important About Models

#### For the search to work in an offline list, we need to implement the following items in your model or in your object's data class:
`toString`, `equals` and also `hashcode`

##### Here's how to do it
```dart
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
  
  //In this case I customized it so that the search returns everything that contains part of the name or age
  @override
  operator ==(object) => this.name.toLowerCase().contains(object.toLowerCase()) || this.age.toString().contains(object);
  
  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
```
## Roadmap

This is our current roadmap. Please, feel free to request additions/changes.

| Feature                            | Progress |
| :--------------------------------- | :------: |
| Offline List                       |    ✅    |
| Http Request Support               |    ✅    |
| Widget Consume for ChangeNotifier  |    ✅    |
| Widget consume for NotifierValue   |    ✅    |
| Just one selected item             |    ✅    |
| Multiple item selection            |    ✅    |
| Search after last input            |    ✅    |
| Cancel to keep old items           |    ✅    |
| Remove items by touch              |    ✅    |
| Nice layout default                |    ✅    |
| Custom layout support              |    ✅    |
| Progress on search request         |    ✅    |
| Custom selected animation          |    ✅    |
| Custom animated action buttons     |    ✅    |
| Custom message when no data found  |    ✅    |
| Custom theme colors                |    ✅    |
| Many other customizations          |    ✅    |
| Documentation - in progress        |    💔    |

## Features and bugs

Please send feature requests and bugs at the [issue tracker](https://github.com/tiagosito/easy_search/issues).
