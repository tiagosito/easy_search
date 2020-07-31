import 'package:flutter/material.dart';

import 'item.dart';
import 'search_item_list.dart';

class SearchItem<T> {
  SearchItem({List<Item> items}) {
    if (items == null || items.length == 0) {
      return;
    } else {
      items.forEach((element) {
        listItems.setListItem(element);
      });
    }
  }

  ValueNotifier<String> filterValue = ValueNotifier<String>('');
  String get filter => filterValue?.value ?? null;
  set filter(String filter) {
    if (this.filterValue == null || this.filterValue.value == null) {
      ValueNotifier<String>('');
    }
    this.filterValue.value = filter;
  }

  ValueNotifier<Item> itemValue;
  Item get item => this.itemValue?.value ?? null;
  set item(Item item) {
    if (item == null) {
      this.itemValue = ValueNotifier<Item>(item);
    } else {
      if (this.itemValue == null) {
        this.itemValue = ValueNotifier<Item>(item);
      } else {
        this.itemValue.value = item;
      }
    }

    updateCountSelected(value: null);

    listItems.getListItems.forEach((element) {
      if (element == this.itemValue.value) {
        listItems.updateList();
        return;
      }
    });
  }

  SearchItemList<T> selectedItems = SearchItemList();
  SearchItemList<T> get getSelectedItems {
    if (getListItems == null) {
      return null;
    }

    selectedItems = SearchItemList();

    var selectedList = getListItems.where((element) => element.selected).toList();
    if (selectedList != null && selectedList.length > 0) {
      selectedList.forEach(
        (element) {
          selectedItems.listItems.value.add(element);
        },
      );
    }

    return selectedItems;
  }

  SearchItemList<T> listItems = SearchItemList();
  List<Item> get getListItems => listItems?.getListItems;
  ValueNotifier<int> countSelectedValue = ValueNotifier<int>(0);
  int get countSelected => countSelectedValue.value = listItems.countSelected();
  updateCountSelected({int value = 0}) {
    if (countSelectedValue == null) {
      countSelectedValue = ValueNotifier<int>(value ?? countSelected);
    } else {
      countSelectedValue.value = value ?? countSelected;
    }
  }

  clear() {
    print('Clear controller');
    filter = '';
    countSelectedValue?.value = 0;
    itemValue?.value = null;
    listItems.clear();
  }
}
