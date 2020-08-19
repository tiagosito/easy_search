import 'package:flutter/material.dart';

import 'label_settings.dart';

class FilterActionButton {
  final Color background;
  final double backgroundOpacity;
  final Color border;
  final double borderOpacity;
  final double borderRadius;
  final LabelSettings textValue;
  final Icon icon;

  const FilterActionButton({
    Color background,
    double backgroundOpacity,
    Color border,
    double borderOpacity,
    double borderRadius,
    LabelSettings textValue,
    Icon icon,
  })  : this.background = background != null ? background : Colors.white,
        this.backgroundOpacity =
            backgroundOpacity != null && backgroundOpacity >= 0.0 && backgroundOpacity <= 1.0 ? backgroundOpacity : 1.0,
        this.border = border != null ? border : null,
        this.borderOpacity = borderOpacity != null && borderOpacity >= 0.0 && borderOpacity <= 1.0 ? borderOpacity : 1.0,
        this.borderRadius = borderRadius != null ? borderRadius : 7.0,
        this.textValue = textValue != null ? textValue : const LabelSettings.filterSelectedButton(),
        this.icon = icon != null ? icon : const Icon(Icons.check, color: null, size: 25);

  const FilterActionButton.unselectedAll({
    Color background,
    double backgroundOpacity,
    Color border,
    double borderOpacity,
    double borderRadius,
    Icon icon,
  })  : this.background = background != null ? background : Colors.red,
        this.backgroundOpacity =
            backgroundOpacity != null && backgroundOpacity >= 0.0 && backgroundOpacity <= 1.0 ? backgroundOpacity : 0.7,
        this.border = border != null ? border : const Color(0xFFD32F2F),
        this.borderOpacity = borderOpacity != null && borderOpacity >= 0.0 && borderOpacity <= 1.0 ? borderOpacity : 1.0,
        this.borderRadius = borderRadius != null ? borderRadius : 35.0,
        this.textValue = null,
        this.icon = icon != null ? icon : const Icon(Icons.clear_all, color: Colors.white, size: 25);

  const FilterActionButton.selectedAll({
    Color background,
    double backgroundOpacity,
    Color border,
    double borderOpacity,
    double borderRadius,
    Icon icon,
  })  : this.background = background != null ? background : Colors.green,
        this.backgroundOpacity =
            backgroundOpacity != null && backgroundOpacity >= 0.0 && backgroundOpacity <= 1.0 ? backgroundOpacity : 0.7,
        this.border = border != null ? border : const Color(0xFF388E3C),
        this.borderOpacity = borderOpacity != null && borderOpacity >= 0.0 && borderOpacity <= 1.0 ? borderOpacity : 1.0,
        this.borderRadius = borderRadius != null ? borderRadius : 35.0,
        this.textValue = null,
        this.icon = icon != null ? icon : const Icon(Icons.done_all, color: Colors.white, size: 25);
}
