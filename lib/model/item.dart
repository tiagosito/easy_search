import 'package:flutter/material.dart';

class Item<T> {
  ValueNotifier<bool> selectedValue = ValueNotifier<bool>(false);
  bool get selected => selectedValue?.value ?? false;
  set selected(bool selected) {
    this.selectedValue.value = selected ?? false;
  }

  ValueNotifier<bool> visibleValue = ValueNotifier<bool>(true);
  bool get visible => visibleValue?.value ?? true;
  set visible(bool visible) {
    this.visibleValue.value = visible ?? true;
  }

  ValueNotifier<bool> selectionHasBeenModifiedValue =
      ValueNotifier<bool>(false);
  bool get selectionHasBeenModified =>
      selectionHasBeenModifiedValue?.value ?? false;
  set selectionHasBeenModified(bool selectionHasBeenModified) {
    this.selectionHasBeenModifiedValue.value =
        selectionHasBeenModified ?? false;
  }

  ValueNotifier<T> itemValue;
  T get item => itemValue?.value ?? null;
  set item(T item) {
    if (item == null) {
      throw ('Item cannot be null');
    }

    if (this.itemValue == null) {
      this.itemValue = ValueNotifier<T>(item);
    } else {
      this.itemValue.value = item;
    }
  }

  Item(T item, bool selected) {
    this.item = item;
    this.selected = selected;
  }
}
