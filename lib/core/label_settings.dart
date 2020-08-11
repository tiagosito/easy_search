import 'package:flutter/material.dart';

class LabelSettings {
  final String value;
  final Color color;
  final double fontSize;

  /// Range to use opacity
  /// [colorOpacity] (which ranges from 0.0 to 1.0)
  ///
  final double colorOpacity;

  final double letterSpacing;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const LabelSettings.searchItem({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value ?? "",
        this.color = color ?? Colors.black,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 14.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 0.7,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 1.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.bold,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.searchLabel({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value ?? "",
        this.color = color ?? Colors.black,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 13.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 0.8,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.searchHint({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value ?? '',
        this.color = color ?? Colors.black,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 14.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 0.5,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.3,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterHint({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value ?? '',
        this.color = color ?? Colors.black,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 14.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 0.5,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.3,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.styleFilterPageTextValue({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value != null ? value : '',
        this.color = color != null ? color : Colors.black,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 15.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 0.5,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.3,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterPageTitle({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    TextAlign textAlign,
    FontWeight fontWeight,
  })  : this.value = value != null ? value : 'Search',
        this.color = color != null ? color : null,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : null,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 1.0,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 1.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterPageCancel({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value != null ? value : 'Cancel',
        this.color = color != null ? color : null,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 14.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 1.0,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 1.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterPageNotFoundMessageAlert({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value != null ? value : 'no data found...',
        this.color = color != null ? color : null,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : 14.0,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 1.0,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 1.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.normal,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterItem({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value != null ? value : 'value...',
        this.color = color != null ? color : null,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : null,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 1.0,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.5,
        this.fontWeight = fontWeight != null ? fontWeight : null,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;

  const LabelSettings.filterSelectedButton({
    String value,
    Color color,
    double fontSize,
    double colorOpacity,
    double letterSpacing,
    FontWeight fontWeight,
    TextAlign textAlign,
  })  : this.value = value != null ? value : 'selected',
        this.color = color != null ? color : null,
        this.fontSize = fontSize != null && fontSize > 0 ? fontSize : null,
        this.colorOpacity =
            colorOpacity != null && colorOpacity >= 0.0 && colorOpacity <= 1.0
                ? colorOpacity
                : 1.0,
        this.letterSpacing =
            letterSpacing != null && letterSpacing >= 0 ? letterSpacing : 0.0,
        this.fontWeight = fontWeight != null ? fontWeight : FontWeight.bold,
        this.textAlign = textAlign != null ? textAlign : TextAlign.start;
}
