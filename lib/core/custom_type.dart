import 'package:flutter/material.dart';

typedef Future<List<T>> OnSearch<T>(String text);
typedef void OnChange<T>(List<T> value);

typedef Widget CustomItemBuilder<T>(
  BuildContext context,
  T item,
  bool isSelected,
);
