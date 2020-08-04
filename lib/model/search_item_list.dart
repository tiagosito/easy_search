import 'package:flutter/material.dart';

import 'item.dart';

class SearchItemList<T> extends ValueNotifier {
  SearchItemList({List<T> items}) : super(items) {
    if (items == null || items.length == 0) {
      return;
    } else {
      items.forEach((element) {
        setListItem((element as Item));
      });
    }
  }

  ValueNotifier<List<Item>> listItems = ValueNotifier<List<Item>>([]);
  List<Item> get getListItems => listItems?.value ?? null;
  setListItem(Item item) {
    if (item == null) {
      return throw ('Search Item cannot be null or empty');
    }

    if (this.listItems == null) {
      List<Item> list = [item];
      this.listItems = ValueNotifier<List<Item>>(list);
    } else {
      var itemsTemp = this.listItems.value.where((element) => element == item).toList();
      if (itemsTemp != null && itemsTemp.length > 0) {
        this.listItems.value.remove(item);
      }
      this.listItems.value.add(item);
    }

    updateList();
  }

  fillItemsList({List<T> items, bool fillSelected = false}) {
    if (items == null) {
      return throw ('Search Items List cannot be null');
    }

    ValueNotifier<List<Item>> listTemp = ValueNotifier<List<Item>>([]);
    items.forEach(
      (element) => listTemp.value.add(
        fillSelected ? element : Item(element, false),
      ),
    );
    this.listItems = listTemp;

    updateList();
  }

  fillSelectedOldItemsFromCancel({List<T> items}) {
    if (items == null) {
      return throw ('Search Items List cannot be null');
    }

    ValueNotifier<List<Item>> listTemp = ValueNotifier<List<Item>>([]);
    items.forEach(
      (element) => listTemp.value.add(
        Item(element, true),
      ),
    );
    this.listItems = listTemp;

    updateList();
  }

  justOneSelected(Item item) {
    getListItems.forEach((element) => element != item ? element.selected = false : element.selected = true);
    updateList();
  }

  ///
  ///[all == true] all items will be selected
  ///
  ///[all == false] all items are unselected
  ///
  selectOrUselecteAll({bool all = true, bool multipleSelect = false}) {
    getListItems.forEach(
      (element) {
        if (multipleSelect) {
          //Select All == True
          if (all) {
            if ((element.selectionHasBeenModified && element.selected) ||
                (!element.selectionHasBeenModified && !element.selected)) {
              element.selectionHasBeenModified = true;
            } else if ((!element.selectionHasBeenModified && element.selected) ||
                (element.selectionHasBeenModified && !element.selected)) {
              element.selectionHasBeenModified = false;
            }

            element.selected = true;
          } else if (!all) {
            //Select All == false
            if ((element.selectionHasBeenModified && element.selected) ||
                (!element.selectionHasBeenModified && !element.selected)) {
              element.selectionHasBeenModified = false;
            } else if ((!element.selectionHasBeenModified && element.selected) ||
                (element.selectionHasBeenModified && !element.selected)) {
              element.selectionHasBeenModified = true;
            }

            element.selected = false;
          }

          // if (!element.selectionHasBeenModified && element.selected != all) {
          //   element.selectionHasBeenModified = false;
          //   element.selected = all;
          // }
          // //Start with false
          // if (!element.selected && !element.selectionHasBeenModified) {
          //   element.selectionHasBeenModified = true;
          // }
          //element.selected = all;
        }
      },
    );
    updateList();
  }

  removeItem(T item) {
    if (item == null) {
      return throw ('Item cannot be null');
    }

    if (this.getListItems == null) {
      return throw ('The list cannot be null');
    }

    if (this.getListItems.length == 0) {
      return throw ('The list is already empty');
    }

    this.listItems.value.remove(item);
    updateList();
  }

  int countSelected() {
    if (getListItems == null) {
      return 0;
    }
    return getListItems.length == 0 ? 0 : getListItems.where((element) => element.selected).toList().length;
  }

  clear() {
    if (this.getListItems == null) {
      return throw ('The list cannot be null');
    }

    this.listItems.value.clear();

    updateList();
  }

  updateList() {
    notifyListeners();
  }
}
