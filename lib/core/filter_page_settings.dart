import 'package:flutter/material.dart';

import 'build_item_filter.dart';
import 'filter_action_button.dart';
import 'filter_field.dart';
import 'label_settings.dart';
import 'list_filter.dart';

class FilterPageSettings {
  final LabelSettings title;
  final bool showBackButon;
  final EdgeInsets padding;
  final FilterField filterField;
  final ListFilter listFilter;
  final BuildItemFilter buildItemFilter;
  final FilterActionButton selectedButton;
  final FilterActionButton selectedAll;
  final FilterActionButton unselectedAll;
  final bool searchOnShow;

  const FilterPageSettings({
    LabelSettings title,
    bool showBackButton,
    EdgeInsets padding,
    FilterField filterField,
    ListFilter listFilter,
    BuildItemFilter buildItemFilter,
    FilterActionButton selectedButton,
    FilterActionButton selectedAll,
    FilterActionButton unselectedAll,
    this.searchOnShow
  })  : this.title =
            title != null ? title : const LabelSettings.filterPageTitle(),
        this.showBackButon = showBackButton ?? false,
        this.padding = padding != null
            ? padding
            : const EdgeInsets.only(
                left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
        this.filterField =
            filterField != null ? filterField : const FilterField(),
        this.listFilter = listFilter != null ? listFilter : const ListFilter(),
        this.buildItemFilter =
            buildItemFilter != null ? buildItemFilter : const BuildItemFilter(),
        this.selectedButton = selectedButton != null
            ? selectedButton
            : const FilterActionButton(),
        this.selectedAll = selectedAll != null
            ? selectedAll
            : const FilterActionButton.selectedAll(),
        this.unselectedAll = unselectedAll != null
            ? unselectedAll
            : const FilterActionButton.unselectedAll();
}
