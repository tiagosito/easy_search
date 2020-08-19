import 'package:flutter/material.dart';

import 'build_item_filter.dart';
import 'filter_action_button.dart';
import 'filter_field.dart';
import 'label_settings.dart';
import 'list_filter.dart';

class FilterPageSettings {
  ///
  /// Parameter name: [title]
  ///
  /// Configure search screen title on [AppBar]
  ///
  final LabelSettings title;

  ///
  /// Parameter name: [showBackButon]
  ///
  /// When this property is
  /// ```dart
  /// showBackButon == true,
  /// ```
  /// Enable the back button on the [AppBar]
  ///
  /// Default value: false
  ///
  final bool showBackButon;

  ///
  /// Parameter name: [padding]
  ///
  /// Configure search screen padding
  ///
  final EdgeInsets padding;

  ///
  /// Parameter name: [filterField]
  ///
  /// Configure the filter field
  ///
  final FilterField filterField;

  ///
  /// Parameter name: [listFilter]
  ///
  /// Show message when no data found
  ///
  /// or show circularProgress when search is runnig
  ///
  final ListFilter listFilter;

  ///
  /// Parameter name: [buildItemFilter]
  ///
  /// Build the item in the searched list
  ///
  final BuildItemFilter buildItemFilter;

  ///
  /// Parameter name: [selectedButton]
  ///
  /// Button to show how many items have already been selected
  ///
  /// and also shows more options
  ///
  /// to select all or deselect all items
  ///
  final FilterActionButton selectedButton;

  ///
  /// Parameter name: [selectedAll]
  ///
  /// Button to select all items
  ///
  final FilterActionButton selectedAll;

  ///
  /// Parameter name: [unselectedAll]
  ///
  /// Button to deselect all items
  ///
  final FilterActionButton unselectedAll;

  ///
  /// Parameter name: [searchOnShow]
  ///
  /// When this property is
  /// ```dart
  /// searchOnShow == true,
  /// ```
  /// Run search automatically when
  ///
  /// opening the search screen
  ///
  /// Default value: false
  ///
  final bool searchOnShow;

  ///
  /// Parameter name: [searchOnEmpty]
  ///
  /// When this property is
  /// ```dart
  /// searchOnEmpty == true,
  /// ```
  /// Run the search
  ///
  /// even when the search field is empty
  ///
  /// Default value: false
  ///
  final bool searchOnEmpty;

  ///
  /// Parameter name: [waitingTimeToSearch]
  ///
  /// Wait a while to perform a search
  ///
  /// after typing the last character
  ///
  /// ```dart
  /// waitingTimeToSearch = 1500, //Duration(milliseconds: 1500)
  /// ```
  ///
  /// Default value: Duration(milliseconds: 1500)
  ///
  final int waitingTimeToSearch;

  const FilterPageSettings(
      {LabelSettings title,
      bool showBackButton,
      EdgeInsets padding,
      FilterField filterField,
      ListFilter listFilter,
      BuildItemFilter buildItemFilter,
      FilterActionButton selectedButton,
      FilterActionButton selectedAll,
      FilterActionButton unselectedAll,
      this.searchOnShow,
      this.searchOnEmpty,
      this.waitingTimeToSearch})
      : this.title =
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
