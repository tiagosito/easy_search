import 'package:flutter/material.dart';

class StyleSearchPage {
  final Color borderColor;
  //final double borderWidth;
  final Color backGroundColor;
  final double backgroundColorOpacity;
  final double borderRadiusCircular;
  final double spacingBetweenItemsValue;
  final double paddingLeftSearchIcon;
  final double paddingRightSearchIcon;

  const StyleSearchPage({
    Color borderColor,
    Color backGroundColor,
    double backgroundColorOpacity,
    double borderRadiusCircular,
    double spacingBetweenItemsValue,
    double paddingLeftSearchIcon,
    double paddingRightSearchIcon,
  })  : this.borderColor = borderColor != null ? borderColor : Colors.grey,
        //this.borderWidth = 0.0,
        this.backGroundColor =
            backGroundColor != null ? backGroundColor : Colors.grey,
        this.backgroundColorOpacity = backgroundColorOpacity != null &&
                backgroundColorOpacity >= 0.0 &&
                backgroundColorOpacity <= 1.0
            ? backgroundColorOpacity
            : 0.15,
        this.borderRadiusCircular =
            borderRadiusCircular != null && borderRadiusCircular > 0
                ? borderRadiusCircular
                : 7.0,
        this.spacingBetweenItemsValue =
            spacingBetweenItemsValue != null && spacingBetweenItemsValue > 0
                ? spacingBetweenItemsValue
                : 8.0,
        this.paddingLeftSearchIcon =
            paddingLeftSearchIcon != null && paddingLeftSearchIcon > 0
                ? paddingLeftSearchIcon
                : 8.0,
        this.paddingRightSearchIcon =
            paddingRightSearchIcon != null && paddingRightSearchIcon > 0
                ? paddingRightSearchIcon
                : 8.0;
}
