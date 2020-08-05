import 'package:flutter/material.dart';

import 'divider_filter_and_list.dart';
import 'label_settings.dart';

class FilterField {
  final Icon prefixIcon;
  final Icon suffixIcon;
  final Color cursor;
  final Color suffixIconBackground;
  final double suffixIconBackgroundOpacity;
  final EdgeInsets sufixCircularPadding;
  final EdgeInsets sufixIconCircularPadding;
  final bool showHint;
  final DividerFilterAndList dividerFilterAndList;
  final LabelSettings labelHint;
  final LabelSettings styleSearchValue;
  final LabelSettings labelCancelFilterSearch;

  const FilterField({
    Icon prefixIcon,
    Icon suffixIcon,
    Color cursor,
    Color suffixIconBackground,
    double suffixIconBackgroundOpacity,
    EdgeInsets sufixCircularPadding,
    EdgeInsets sufixIconCircularPadding,
    bool showHint,
    LabelSettings labelHint,
    LabelSettings styleSearchValue,
    LabelSettings labelCancelFilterSearch,
    DividerFilterAndList dividerFilterAndList,
  })  : this.prefixIcon = prefixIcon != null
            ? prefixIcon
            : const Icon(Icons.search, color: Colors.grey, size: 22),
        this.suffixIcon = suffixIcon != null
            ? suffixIcon
            : const Icon(Icons.clear, color: Colors.white, size: 15),
        this.cursor = cursor != null ? cursor : null,
        this.suffixIconBackground =
            suffixIconBackground != null ? suffixIconBackground : Colors.grey,
        this.suffixIconBackgroundOpacity =
            suffixIconBackgroundOpacity != null &&
                    suffixIconBackgroundOpacity >= 0.0 &&
                    suffixIconBackgroundOpacity <= 1.0
                ? suffixIconBackgroundOpacity
                : 1.0,
        this.sufixCircularPadding = sufixCircularPadding != null
            ? sufixCircularPadding
            : const EdgeInsets.all(7.0),
        this.sufixIconCircularPadding = sufixIconCircularPadding != null
            ? sufixIconCircularPadding
            : const EdgeInsets.all(0),
        this.showHint = showHint ?? true,
        this.labelHint =
            labelHint != null ? labelHint : const LabelSettings.filterHint(),
        this.styleSearchValue = styleSearchValue != null
            ? styleSearchValue
            : const LabelSettings.styleFilterPageTextValue(),
        this.labelCancelFilterSearch = labelCancelFilterSearch != null
            ? labelCancelFilterSearch
            : const LabelSettings.filterPageCancel(),
        this.dividerFilterAndList = dividerFilterAndList != null
            ? dividerFilterAndList
            : const DividerFilterAndList();
}
