import 'package:easy_search/easy_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final easySearch = EasySearch(
    controller: SearchItem(items: []),
  );

  test('Controller is not null', () {
    expect(easySearch.controller != null, true);
    expect(easySearch.controller.countSelected, 0);
  });
  test('CountSelected == 0', () {
    expect(easySearch.controller.countSelected, 0);
  });

  test('SearchResultSettings is not null', () {
    expect(easySearch.searchResultSettings != null, true);
  });
}
