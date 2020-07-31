import 'package:flutter/material.dart';

import 'label_settings.dart';

class ListFilter {
  final LabelSettings valueNotFoundAlert;
  final Color circularProgress;

  const ListFilter({
    LabelSettings valueNotFoundAlert,
    Color circularProgress,
  })  : this.valueNotFoundAlert =
            valueNotFoundAlert != null ? valueNotFoundAlert : const LabelSettings.filterPageNotFoundMessageAlert(),
        this.circularProgress = circularProgress != null ? circularProgress : null;
}
