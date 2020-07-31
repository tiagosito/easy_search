import 'package:flutter/material.dart';

import 'label_settings.dart';

class BuildItemResult {
  final Color highlightColor;
  final Color splashColor;
  final double circularBackgroundBorderRadius;
  final EdgeInsets backgroundPadding;
  final Color backgroundColor;
  final double backgroundOpacity;
  final double circularBorderRadiusItem;
  final EdgeInsets itemPadding;
  final double spacingBetweenItem;
  final LabelSettings itemValue;
  final IconData removeItemIcon;
  final Color removeItemIconColor;
  final double removeItemIconOpacity;
  final Color removeItemIconBackgroundColor;
  final double removeItemIconBackgroundOpacity;

  const BuildItemResult({
    Color highlightColor,
    Color splashColor,
    double circularBackgroundBorderRadius,
    EdgeInsets backgroundPadding,
    Color backgroundColor,
    double backgroundOpacity,
    double circularBorderRadiusItem,
    EdgeInsets itemPadding,
    double spacingBetweenItem,
    LabelSettings itemValue,
    IconData removeItemIcon,
    Color removeItemIconColor,
    double removeItemIconOpacity,
    Color removeItemIconBackgroundColor,
    double removeItemIconBackgroundOpacity,
  })  : this.highlightColor = highlightColor != null ? highlightColor : Colors.red,
        this.splashColor = splashColor != null ? splashColor : null,
        this.circularBackgroundBorderRadius = circularBackgroundBorderRadius != null ? circularBackgroundBorderRadius : 17.0,
        this.backgroundPadding = backgroundPadding != null ? backgroundPadding : const EdgeInsets.symmetric(vertical: 2.0),
        this.backgroundColor = backgroundColor != null ? backgroundColor : Colors.grey,
        this.backgroundOpacity =
            backgroundOpacity != null && backgroundOpacity >= 0.0 && backgroundOpacity <= 1.0 ? backgroundOpacity : 0.1,
        this.circularBorderRadiusItem = circularBorderRadiusItem != null ? circularBorderRadiusItem : 17.0,
        this.itemPadding =
            itemPadding != null ? itemPadding : const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
        this.spacingBetweenItem = spacingBetweenItem != null ? spacingBetweenItem : 5.0,
        this.itemValue = itemValue != null ? itemValue : const LabelSettings.searchItem(),
        this.removeItemIcon = removeItemIcon != null ? removeItemIcon : Icons.close,
        this.removeItemIconColor = removeItemIconColor != null ? removeItemIconColor : Colors.red,
        this.removeItemIconOpacity = removeItemIconOpacity != null && removeItemIconOpacity >= 0.0 && removeItemIconOpacity <= 1.0
            ? removeItemIconOpacity
            : 0.8,
        this.removeItemIconBackgroundColor = removeItemIconBackgroundColor != null ? removeItemIconBackgroundColor : Colors.white,
        this.removeItemIconBackgroundOpacity = removeItemIconBackgroundOpacity != null &&
                removeItemIconBackgroundOpacity >= 0.0 &&
                removeItemIconBackgroundOpacity <= 1.0
            ? removeItemIconBackgroundOpacity
            : 0.8;
}
