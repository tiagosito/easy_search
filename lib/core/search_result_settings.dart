import 'package:flutter/material.dart';

import 'build_item_result.dart';
import 'label_settings.dart';
import 'style_search_page.dart';

class SearchResultSettings {
  final LabelSettings label;
  final LabelSettings labelHint;
  final Icon prefixIcon;
  final EdgeInsets padding;
  final StyleSearchPage styleSearchPage;
  final BuildItemResult buildItemResult;

  const SearchResultSettings({
    this.label,
    this.labelHint,
    this.prefixIcon = const Icon(Icons.search, color: Colors.grey, size: 22),
    EdgeInsets padding,
    StyleSearchPage styleSearchPage,
    BuildItemResult buildItemResult,
  })  : this.padding = padding != null ? padding : const EdgeInsets.all(0.0),
        this.styleSearchPage =
            styleSearchPage != null ? styleSearchPage : const StyleSearchPage(),
        this.buildItemResult =
            buildItemResult != null ? buildItemResult : const BuildItemResult();
}
