import 'package:flutter/material.dart';

class DividerFilterAndList {
  final Color color;
  final double opacity;
  final double size;

  const DividerFilterAndList({
    Color color,
    double opacity,
    double size,
  })  : this.color = color != null ? color : const Color(0xffe6e6ea),
        this.opacity = opacity != null && opacity >= 0.0 && opacity <= 1.0 ? opacity : 1.0,
        this.size = size != null && size >= 0.0 && size <= 1.0 ? size : 1.0;
}
