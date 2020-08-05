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

  final SearchResultSettings searchResultSettings;
  final FilterPageSettings filterPageSettings;
  final bool multipleSelect;
  final SearchItem controller;
  final OnSearch<T> onSearch;
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var discountSpace = (widget.searchResultSettings.prefixIcon.size ?? 24.0) +
        widget.searchResultSettings.padding.left +
        widget.searchResultSettings.padding.right +
        widget.searchResultSettings.styleSearchPage.paddingLeftSearchIcon +
        widget.searchResultSettings.styleSearchPage.paddingRightSearchIcon +
        (_borderWidth * 2);

    var listItemsWidthInternal = size.width - discountSpace;

    var textLabel = Text(
      widget.searchResultSettings.label.value,
      style: TextStyle(
        fontSize: widget.searchResultSettings.label.fontSize,
        fontWeight: widget.searchResultSettings.label.fontWeight,
        letterSpacing: widget.searchResultSettings.label.letterSpacing,
        color: widget.searchResultSettings.label.color
            .withOpacity(widget.searchResultSettings.label.colorOpacity),
      ),
    );
    var textLabelHide = Text(
      widget.searchResultSettings.label.value,
      style: TextStyle(
        fontSize: widget.searchResultSettings.label.fontSize,
        fontWeight: widget.searchResultSettings.label.fontWeight,
        letterSpacing: widget.searchResultSettings.label.letterSpacing,
        color: Colors.transparent,
      ),
    );
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
                      //Call SearchScreenList

                      //cloneController();
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

                      if (result == null) {
                        print('No items were selected');
                        // _controller.clear();
                        // _controller = (result as SearchItem);

                        //_controller = _oldController;
                        //backCloneControllerValues();
                      } else {
                        _controller.listItems.updateList();
                        var itemsTemp = (result as SearchItem);
                        if (itemsTemp == null ||
                            itemsTemp.listItems == null ||
                            itemsTemp.listItems.getListItems.length == 0) {
                          print('No items were selected');
                          _controller.clear();
                          // _controller = (result as SearchItem);
                        } else {
                          //Check items selected == true;

                          var selectedList = itemsTemp
                              .getSelectedItems.getListItems
                              .where((element) => element.selected)
                              .toList();
                          // if (itemsTemp.getSelectedItems != null) {
                          // }

                          // var selectedList = itemsTemp.listItems.getListItems.where((element) => element.selected).toList();

                          // _controller.listItems.fillItemsList(items: selectedList, fillSelected: true);

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
                      widget.searchResultSettings.prefixIcon,
                      SizedBox(
                        width: widget.searchResultSettings.styleSearchPage
                            .paddingRightSearchIcon,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ValueListenableBuilder(
                          valueListenable: _controller?.listItems,
                          builder: (_, __, ___) {
                            return Container(
                              width: listItemsWidthInternal,
                              child: this._controller != null &&
                                      this._controller.getSelectedItems !=
                                          null &&
                                      this
                                              ._controller
                                              .getSelectedItems
                                              .getListItems !=
                                          null &&
                                      this
                                              ._controller
                                              .getSelectedItems
                                              .getListItems
                                              .length >
                                          0
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
                                  : Text(
                                      widget.searchResultSettings.labelHint
                                                      .value !=
                                                  null &&
                                              widget.searchResultSettings
                                                      .labelHint.value
                                                      .replaceAll(' ', '')
                                                      .length >
                                                  0
                                          ? widget.searchResultSettings
                                              .labelHint.value
                                          : 'search...',
                                      style: TextStyle(
                                        fontSize: widget.searchResultSettings
                                            .labelHint.fontSize,
                                        fontWeight: widget.searchResultSettings
                                            .labelHint.fontWeight,
                                        letterSpacing: widget
                                            .searchResultSettings
                                            .labelHint
                                            .letterSpacing,
                                        color: widget.searchResultSettings
                                            .labelHint.color
                                            .withOpacity(widget
                                                .searchResultSettings
                                                .labelHint
                                                .colorOpacity),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.searchResultSettings.label.value != null &&
                widget.searchResultSettings.label.value.isNotEmpty)
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
            if (widget.searchResultSettings.label.value != null &&
                widget.searchResultSettings.label.value.isNotEmpty)
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
