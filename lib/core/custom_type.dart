import 'package:flutter/material.dart';

typedef Future<List<T>> OnSearch<T>(String text);

typedef Widget CustomItemBuilder<T>(
  BuildContext context,
  T item,
  bool isSelected,
);
