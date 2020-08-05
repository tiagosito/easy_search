import 'package:flutter/material.dart';

import 'curve_type.dart';
import 'label_settings.dart';

class BuildItemFilter {
  final EdgeInsets padding;
  final double circularBorderRadiusItem;
  final EdgeInsets spaceBetweenItems;
  final Color backgroundSelectedItem;
  final double backgroundSelectedItemOpacity;
  final Color borderSelectedItem;
  final double borderSelectedItemOpacity;
  final double circularBorderRadiusBackgroundItem;
  final EdgeInsets backgroundValuePadding;
  final EdgeInsets valuePadding;
  final LabelSettings itemValue;
  final CrossAxisAlignment crossAxisAlignment;
  final bool hasAnimationOnSelectItem;
  final double increaseHeightWhenAnimating;
  final int animationDurationMilliseconds;
  final CurvesType curves;
  final Icon iconAnimation;

  const BuildItemFilter({
    EdgeInsets padding,
    double circularBorderRadiusItem,
    EdgeInsets spaceBetweenItems,
    Color backgroundSelectedItem,
    double backgroundSelectedItemOpacity,
    Color borderSelectedItem,
    double borderSelectedItemOpacity,
    double circularBorderRadiusBackgroundItem,
    EdgeInsets backgroundValuePadding,
    EdgeInsets valuePadding,
    LabelSettings itemValue,
    CrossAxisAlignment crossAxisAlignment,
    bool hasAnimationOnSelectItem,
    double increaseHeightWhenAnimating,
    int animationDurationMilliseconds,
    CurvesType curves,
    Icon iconAnimation,
  })  : this.padding = padding != null
            ? padding
            : const EdgeInsets.only(
                left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
        this.circularBorderRadiusItem =
            circularBorderRadiusItem != null ? circularBorderRadiusItem : 7.0,
        this.spaceBetweenItems = spaceBetweenItems != null
            ? spaceBetweenItems
            : const EdgeInsets.only(
                left: 0.0, top: 2.0, right: 0.0, bottom: 2.0),
        this.backgroundSelectedItem =
            backgroundSelectedItem != null ? backgroundSelectedItem : null,
        this.backgroundSelectedItemOpacity =
            backgroundSelectedItemOpacity != null &&
                    backgroundSelectedItemOpacity >= 0.0 &&
                    backgroundSelectedItemOpacity <= 1.0
                ? backgroundSelectedItemOpacity
                : 0.1,
        this.borderSelectedItem =
            borderSelectedItem != null ? borderSelectedItem : null,
        this.borderSelectedItemOpacity = borderSelectedItemOpacity != null &&
                borderSelectedItemOpacity >= 0.0 &&
                borderSelectedItemOpacity <= 1.0
            ? borderSelectedItemOpacity
            : 0.3,
        this.circularBorderRadiusBackgroundItem =
            circularBorderRadiusBackgroundItem != null
                ? circularBorderRadiusBackgroundItem
                : 7.0,
        this.backgroundValuePadding = backgroundValuePadding != null
            ? backgroundValuePadding
            : const EdgeInsets.only(
                left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
        this.valuePadding = valuePadding != null
            ? valuePadding
            : const EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
        this.itemValue =
            itemValue != null ? itemValue : const LabelSettings.filterItem(),
        this.crossAxisAlignment = crossAxisAlignment != null
            ? crossAxisAlignment
            : CrossAxisAlignment.start,
        this.hasAnimationOnSelectItem =
            hasAnimationOnSelectItem != null ? hasAnimationOnSelectItem : true,
        this.increaseHeightWhenAnimating = increaseHeightWhenAnimating != null
            ? increaseHeightWhenAnimating
            : 25.0,
        this.animationDurationMilliseconds =
            animationDurationMilliseconds != null
                ? animationDurationMilliseconds
                : 100,
        this.curves = curves != null ? curves : CurvesType.fastOutSlowIn,
        this.iconAnimation = iconAnimation != null
            ? iconAnimation
            : const Icon(Icons.check, color: null, size: 25);
}
