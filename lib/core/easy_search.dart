import 'package:easy_search/model/search_Item.dart';
import 'package:flutter/material.dart';

import '../easy_search.dart';
import 'custom_type.dart';
import 'filter_page_settings.dart';
import 'search_result_settings.dart';
import 'search_screen_list.dart';

class EasySearch<T> extends StatefulWidget {
  const EasySearch({
    Key key,
    SearchResultSettings searchResultSettings,
    FilterPageSettings filterPageSettings,
    bool multipleSelect,
    this.controller,
    this.onSearch,
    this.customItemBuilder,
  })  : this.searchResultSettings = searchResultSettings != null
            ? searchResultSettings
            : const SearchResultSettings(),
        this.filterPageSettings = filterPageSettings != null
            ? filterPageSettings
            : const FilterPageSettings(),
        this.multipleSelect = multipleSelect ?? false,
        super(key: key);

  ///
  /// Parameter name: [searchResultSettings]
  ///
  /// Configure the display of the results list
  ///
  final SearchResultSettings searchResultSettings;

  ///
  /// Parameter name: [filterPageSettings]
  ///
  /// Configure the display of the filter list
  ///
  final FilterPageSettings filterPageSettings;

  ///
  /// Parameter name: [multipleSelect]
  ///
  /// When this property is
  /// ```dart
  /// multipleSelect == true,
  /// ```
  /// it enables multiple selection in the filter list
  ///
  /// Default value: false
  ///
  final bool multipleSelect;

  ///
  /// Parameter name: [controller]
  ///
  /// It is the controller of the component,
  ///
  /// in general, we have it, the filter list control,
  ///
  /// results list, quantity of selected items
  ///
  final SearchItem controller;

  ///
  /// Parameter name: [onSearch]
  ///
  /// The method that will be invoked,
  ///
  /// when making a call to a web server
  ///
  final OnSearch<T> onSearch;

  ///
  /// Parameter name: [customItemBuilder]
  ///
  /// This is the parameter responsible for injecting your customized code,
  ///
  /// into the filter items, in short,
  ///
  /// here you can customize
  ///
  /// how your filter list will present the items
  ///
  final CustomItemBuilder<T> customItemBuilder;

  @override
  _EasySearchState<T> createState() =>
      _EasySearchState<T>(controller: controller);
}

class _EasySearchState<T> extends State<EasySearch<T>> {
  SearchItem _controller;
  double _borderWidth;
  SearchItem _oldController = SearchItem(items: []);
  _EasySearchState({SearchItem controller}) {
    _controller = controller ?? SearchItem(items: []);
    _borderWidth = 0.0;
  }

  @override
  void initState() {
    super.initState();
    if (widget.onSearch == null && widget.controller == null) {
      throw ('STOP: hOoo no Dev,\nThe controller cannot be null if OnSearch is also null');
    }

    if (widget.onSearch != null && widget.controller != null) {
      //Ignore offline list when OnSearch and Controller is not null
      _controller = SearchItem(items: []);
    }
  }

  Widget _label(LabelSettings settings, [String defaultValue = ""]) {
    return settings != null
        ? Text(
            settings.value ?? defaultValue,
            style: TextStyle(
              fontSize: settings.fontSize,
              fontWeight: settings.fontWeight,
              letterSpacing: settings.letterSpacing,
              color: settings.color.withOpacity(settings.colorOpacity),
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    Text textLabel;
    Text textLabelHide;

    if (widget.searchResultSettings?.label != null) {
      textLabel = _label(widget.searchResultSettings.label);

      textLabelHide = Text(
        widget.searchResultSettings.label.value,
        style: TextStyle(
          fontSize: widget.searchResultSettings.label.fontSize,
          fontWeight: widget.searchResultSettings.label.fontWeight,
          letterSpacing: widget.searchResultSettings.label.letterSpacing,
          color: Colors.transparent,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
          left: widget.searchResultSettings.padding.left,
          top: widget.searchResultSettings.padding.top,
          right: widget.searchResultSettings.padding.right,
          bottom: widget.searchResultSettings.padding.bottom),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: widget
                          .searchResultSettings.styleSearchPage.borderColor,
                      width: _borderWidth),
                  color: widget
                      .searchResultSettings.styleSearchPage.backGroundColor
                      .withOpacity(widget.searchResultSettings.styleSearchPage
                          .backgroundColorOpacity),
                  borderRadius: BorderRadius.circular(widget
                      .searchResultSettings
                      .styleSearchPage
                      .borderRadiusCircular),
                ),
                constraints: BoxConstraints(
                  minHeight: 33.0,
                ),
                child: InkWell(
                  onTap: () async {
                    if ((_controller == null ||
                            _controller.listItems == null ||
                            _controller.listItems.getListItems == null ||
                            _controller.listItems.getListItems.length == 0) &&
                        widget.onSearch == null) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Oh no, the list is empty!',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 1500),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      _controller.filter = '';
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreenList(
                            filterPageSettings: widget.filterPageSettings,
                            controller: _controller,
                            multipleSelect: widget.multipleSelect,
                            onSearch: widget.onSearch,
                            customItemBuilder: widget.customItemBuilder,
                          ),
                        ),
                      );

                      if (result != null) {
                        _controller.listItems.updateList();
                        var itemsTemp = (result as SearchItem);
                        if (itemsTemp == null ||
                            itemsTemp.listItems == null ||
                            itemsTemp.listItems.getListItems.length == 0) {
                          print('No items were selected');
                          _controller.clear();
                        } else {
                          //Check items selected == true;

                          var selectedList = itemsTemp
                              .getSelectedItems.getListItems
                              .where((element) => element.selected)
                              .toList();
                          if (_controller != null &&
                              _controller.getSelectedItems.getListItems.length >
                                  0) {
                            for (var itemSelected in selectedList) {
                              print(
                                  'Item: ${itemSelected.item}  -  Selected: ${itemSelected.selected}');
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: widget.searchResultSettings.styleSearchPage
                            .paddingLeftSearchIcon,
                      ),
                      widget.searchResultSettings.prefix ??
                          const Icon(Icons.search,
                              color: Colors.grey, size: 22),
                      SizedBox(
                        width: widget.searchResultSettings.styleSearchPage
                            .paddingRightSearchIcon,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ValueListenableBuilder(
                            valueListenable: _controller?.listItems,
                            builder: (_, __, ___) {
                              return this._controller?.hasSelection == true
                                  ? Wrap(
                                      spacing: widget
                                          .searchResultSettings
                                          .styleSearchPage
                                          .spacingBetweenItemsValue,
                                      children: buildTextItem(
                                        context: context,
                                        searchItem: _controller,
                                      ),
                                    )
                                  : _label(
                                          widget.searchResultSettings.labelHint,
                                          "search...") ??
                                      Container();
                            },
                          ),
                        ),
                      ),
                      widget.searchResultSettings.sufix ?? Container(),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.searchResultSettings.label?.value != null &&
                widget.searchResultSettings.label?.value?.isNotEmpty == true)
              Positioned(
                left: 20,
                top: 9.5,
                height: _borderWidth == 0 ? 1 : _borderWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: textLabelHide,
                    ),
                  ),
                ),
              ),
            if (widget.searchResultSettings.label?.value != null &&
                widget.searchResultSettings.label?.value?.isNotEmpty == true)
              Positioned(
                left: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    color: Colors.transparent,
                    child: textLabel,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildTextItem({BuildContext context, SearchItem searchItem}) {
    List<Widget> listWidget = List();
    for (var element in searchItem.getSelectedItems.getListItems) {
      listWidget.add(
        InkWell(
          highlightColor:
              widget.searchResultSettings.buildItemResult.highlightColor,
          splashColor:
              widget.searchResultSettings.buildItemResult.splashColor ??
                  Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(widget.searchResultSettings
              .buildItemResult.circularBackgroundBorderRadius),
          onTap: () {
            print('The item - ${element.item.toString()} has been removed');
            element.selected = false;
            _controller.listItems.updateList();
            //_controller.selectedItems.removeItem(element);
          },
          child: Padding(
            padding:
                widget.searchResultSettings.buildItemResult.backgroundPadding,
            child: Container(
              decoration: BoxDecoration(
                color: widget
                    .searchResultSettings.buildItemResult.backgroundColor
                    .withOpacity(widget.searchResultSettings.buildItemResult
                        .backgroundOpacity),
                borderRadius: BorderRadius.circular(widget.searchResultSettings
                    .buildItemResult.circularBorderRadiusItem),
              ),
              child: Padding(
                padding:
                    widget.searchResultSettings.buildItemResult.itemPadding,
                child: Wrap(
                  spacing: widget
                      .searchResultSettings.buildItemResult.spacingBetweenItem,
                  children: [
                    Text(
                      element.item.toString(),
                      style: TextStyle(
                        fontSize: widget.searchResultSettings.buildItemResult
                            .itemValue.fontSize,
                        fontWeight: widget.searchResultSettings.buildItemResult
                            .itemValue.fontWeight,
                        letterSpacing: widget.searchResultSettings
                            .buildItemResult.itemValue.letterSpacing,
                        color: widget.searchResultSettings.buildItemResult
                            .itemValue.color
                            .withOpacity(widget.searchResultSettings
                                .buildItemResult.itemValue.colorOpacity),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: widget.searchResultSettings.buildItemResult
                              .removeItemIconBackgroundColor
                              .withOpacity(widget
                                  .searchResultSettings
                                  .buildItemResult
                                  .removeItemIconBackgroundOpacity),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.searchResultSettings.buildItemResult
                              .removeItemIcon,
                          color: widget.searchResultSettings.buildItemResult
                                      .removeItemIconBackgroundColor !=
                                  widget.searchResultSettings.buildItemResult
                                      .removeItemIconColor
                              ? widget.searchResultSettings.buildItemResult
                                  .removeItemIconColor
                                  .withOpacity(widget.searchResultSettings
                                      .buildItemResult.removeItemIconOpacity)
                              : Theme.of(context).primaryColor !=
                                      widget.searchResultSettings
                                          .buildItemResult.backgroundColor
                                  ? Theme.of(context).primaryColor.withOpacity(
                                      widget.searchResultSettings.buildItemResult.removeItemIconOpacity)
                                  : Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listWidget;
  }

  //Clone Controller to return the data when the user cancels
  void cloneController() {
    _oldController = SearchItem(items: []);
    _oldController.filterValue.value = _controller.filterValue.value;
    _oldController.itemValue = _controller.itemValue;
    _oldController.listItems = _controller.listItems;
    _oldController.getSelectedItems;
  }

  //Back Clone Controller Values
  void backCloneControllerValues() {
    var listTemp = List<Item>();
    _controller.filterValue.value = _oldController.filterValue.value;
    _controller.itemValue = _oldController.itemValue;

    _oldController.listItems?.getListItems?.forEach(
      (element) => listTemp.add(
        Item(element.itemValue.value, element.selectedValue.value),
      ),
    );

    _controller.listItems?.listItems?.value?.clear();

    listTemp?.forEach(
      (element) => _controller.listItems.listItems.value.add(
        Item(element.itemValue.value, element.selectedValue.value),
      ),
    );
    _controller.getSelectedItems;
  }
}
