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
    LabelSettings label,
    LabelSettings labelHint,
    Icon prefixIcon,
    EdgeInsets padding,
    StyleSearchPage styleSearchPage,
    BuildItemResult buildItemResult,
  })  : this.padding = padding != null ? padding : const EdgeInsets.all(0.0),
        this.label = label != null ? label : const LabelSettings.searchLabel(),
        this.labelHint = labelHint != null ? labelHint : const LabelSettings.searchHint(),
        this.prefixIcon = prefixIcon != null ? prefixIcon : const Icon(Icons.search, color: Colors.grey, size: 22),
        this.styleSearchPage = styleSearchPage != null ? styleSearchPage : const StyleSearchPage(),
        this.buildItemResult = buildItemResult != null ? buildItemResult : const BuildItemResult();
}
