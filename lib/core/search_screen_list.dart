import 'dart:async';

import 'package:easy_search/model/item.dart';
import 'package:easy_search/model/search_Item.dart';
import 'package:easy_search/model/search_item_list.dart';
import 'package:flutter/material.dart';

import 'curve_type.dart';
import 'custom_type.dart';
import 'filter_page_settings.dart';

class SearchScreenList<T> extends StatefulWidget {
  final FilterPageSettings filterPageSettings;

  final bool multipleSelect;
  final SearchItem controller;
  final OnSearch<T> onSearch;
  final CustomItemBuilder<T> customItemBuilder;

  const SearchScreenList({
    Key key,
    this.filterPageSettings,
    this.multipleSelect,
    this.controller,
    this.onSearch,
    this.customItemBuilder,
  }) : super(key: key);
  @override
  _SearchScreenListState<T> createState() => _SearchScreenListState<T>(controller: controller);
}

class _SearchScreenListState<T> extends State<SearchScreenList<T>> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationSelectAll;
  Animation<double> _animationUnselectAll;
  bool _longPressSelectItems = false;

  bool _loading = false;
  bool _enableSearch = true;
  String _lastSearchValue = '';
  Timer _searchTimer;
  int _waitingTimeToSearch = 1500;
  SearchItem _oldController = SearchItem(items: []);
  var _textEditingController = TextEditingController();
  _SearchScreenListState({SearchItem controller}) {
    cloneController(controller);
  }

  @override
  void initState() {
    _textEditingController.addListener(configureSearchTimer);

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _animationSelectAll = CurvedAnimation(parent: _animationController, curve: Interval(0.0, 1.0, curve: Curves.linear));

    _animationUnselectAll = CurvedAnimation(parent: _animationController, curve: Interval(0.7, 1.0, curve: Curves.linear));

    _animationController.reverse();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(configureSearchTimer);
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _requestPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: widget.filterPageSettings.padding, //General Padding
                    child: Row(
                      children: [
                        //TextField Search
                        Expanded(
                          child: Container(
                            height: 35,
                            child: buildTextFieldFilter(context),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //Button Cancel
                        Container(
                          height: 35,
                          child: buildFlatButtonCancel(context),
                        ),
                      ],
                    ),
                  ),
                  buildDividerBetweenFilterAndList(context),
                ],
              ),
              SizedBox(
                height: 0.5,
              ),
              //Build Item list
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: widget.controller.listItems,
                  builder: (context, value, child) {
                    return (_loading)
                        ? buildProgress(context)
                        : (widget.controller == null ||
                                widget.controller.listItems == null ||
                                widget.controller.listItems.getListItems == null ||
                                widget.controller.listItems.getListItems.length == 0)
                            ? buildMessageNotFound(context)
                            : buildListItems();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: widget.multipleSelect
            ? ValueListenableBuilder(
                valueListenable: widget.controller.countSelectedValue,
                builder: (context, value, child) {
                  return widget.controller.countSelected > 0
                      ? Container(
                          height: 200,
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  buildUnselectAll(),
                                  SizedBox(height: 10),
                                  buildSelectAll(),
                                  SizedBox(height: 10),
                                  buildSelectItems(context),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
              )
            : null,
      ),
    );
  }

  //Build AppBar
  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        widget.filterPageSettings.title.value,
        style: TextStyle(
          color: widget.filterPageSettings.title.color == null
              ? Colors.white.withOpacity(widget.filterPageSettings.title.colorOpacity)
              : widget.filterPageSettings.title.color?.withOpacity(
                  widget.filterPageSettings.title.colorOpacity,
                ),
          fontSize: widget.filterPageSettings.title.fontSize,
          letterSpacing: widget.filterPageSettings.title.letterSpacing,
          fontWeight: widget.filterPageSettings.title.fontWeight,
        ),
      ),
      automaticallyImplyLeading: widget.filterPageSettings.showBackButon,
    );
  }

  //Build TextField Filter
  Widget buildTextFieldFilter(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onSubmitted: (value) {
        _enableSearch = false;
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) async {
        _enableSearch = true;
        widget.controller.filter = value;
      },
      style: TextStyle(
        fontSize: widget.filterPageSettings.filterField.styleSearchValue.fontSize,
        color: widget.filterPageSettings.filterField.styleSearchValue.color
            .withOpacity(widget.filterPageSettings.filterField.styleSearchValue.colorOpacity),
        fontWeight: widget.filterPageSettings.filterField.styleSearchValue.fontWeight,
        letterSpacing: widget.filterPageSettings.filterField.styleSearchValue.letterSpacing,
      ),
      autofocus: true,
      autocorrect: false,
      cursorColor: widget.filterPageSettings.filterField.cursor != null
          ? widget.filterPageSettings.filterField.cursor
          : Theme.of(context).primaryColor,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        fillColor: Color(0xffe6e6ea).withOpacity(0.5),
        hintStyle: TextStyle(
            fontSize: widget.filterPageSettings.filterField.labelHint.fontSize,
            color: widget.filterPageSettings.filterField.labelHint.color
                .withOpacity(widget.filterPageSettings.filterField.labelHint.colorOpacity),
            letterSpacing: widget.filterPageSettings.filterField.labelHint.letterSpacing,
            fontWeight: widget.filterPageSettings.filterField.labelHint.fontWeight),
        hintText: widget.filterPageSettings.filterField.labelHint.value,
        prefixIcon: widget.filterPageSettings.filterField.prefixIcon,
        suffixIcon: widget.controller != null && widget.controller.filterValue != null
            ? ValueListenableBuilder(
                valueListenable: widget.controller?.filterValue,
                builder: (_, __, ___) {
                  return widget.controller.filter == null || widget.controller.filter.length == 0
                      ? Container(
                          width: 0,
                          color: Colors.transparent,
                        )
                      : Padding(
                          padding: widget.filterPageSettings.filterField.sufixCircularPadding,
                          child: Container(
                            height: 5,
                            width: 5,
                            child: MaterialButton(
                              onPressed: () {
                                widget.controller.filter = null;
                                WidgetsBinding.instance.addPostFrameCallback((_) => _textEditingController.clear());
                                FocusScope.of(context).unfocus();
                              },
                              color: widget.filterPageSettings.filterField.suffixIconBackground
                                  .withOpacity(widget.filterPageSettings.filterField.suffixIconBackgroundOpacity),
                              child: Icon(
                                widget.filterPageSettings.filterField.suffixIcon.icon,
                                size: widget.filterPageSettings.filterField.suffixIcon.size,
                                color: widget.filterPageSettings.filterField.suffixIcon.color,
                              ),
                              padding: widget.filterPageSettings.filterField.sufixIconCircularPadding, //Clear X Padding
                              shape: CircleBorder(),
                            ),
                          ),
                        );
                },
              )
            : Container(
                height: 0,
                width: 0,
              ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 0, color: Color(0xffe6e6ea)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 0.7, color: Color(0xffe6e6ea)),
        ),
      ),
    );
  }

  //Build FlatButton Cancel
  Widget buildFlatButtonCancel(BuildContext context) {
    return FlatButton(
      child: Text(
        widget.filterPageSettings.filterField.labelCancelFilterSearch.value == null ||
                widget.filterPageSettings.filterField.labelCancelFilterSearch.value.replaceAll(' ', '').length == 0
            ? 'Cancel'
            : widget.filterPageSettings.filterField.labelCancelFilterSearch.value,
        style: TextStyle(
          color: widget.filterPageSettings.filterField.labelCancelFilterSearch.color != null
              ? widget.filterPageSettings.filterField.labelCancelFilterSearch.color
                  .withOpacity(widget.filterPageSettings.filterField.labelCancelFilterSearch.colorOpacity)
              : Theme.of(context)
                  .primaryColor
                  .withOpacity(widget.filterPageSettings.filterField.labelCancelFilterSearch.colorOpacity),
          fontWeight: widget.filterPageSettings.filterField.labelCancelFilterSearch.fontWeight,
          fontSize: widget.filterPageSettings.filterField.labelCancelFilterSearch.fontSize,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        _pop(context: context, cancel: true);
        // _pop(context: context);
      },
    );
  }

  //Build Divider Between Filter And List
  Widget buildDividerBetweenFilterAndList(BuildContext context) {
    return Container(
      color: widget.filterPageSettings.filterField.dividerFilterAndList.color
          .withOpacity(widget.filterPageSettings.filterField.dividerFilterAndList.opacity),
      height: widget.filterPageSettings.filterField.dividerFilterAndList.size,
      width: MediaQuery.of(context).size.width,
    );
  }

  //Build Progress
  Widget buildProgress(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.filterPageSettings.listFilter.circularProgress != null
              ? widget.filterPageSettings.listFilter.circularProgress
              : Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  //Build Message Not Found
  Widget buildMessageNotFound(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          widget.filterPageSettings.listFilter.valueNotFoundAlert.value,
          style: TextStyle(
            color: widget.filterPageSettings.listFilter.valueNotFoundAlert.color != null
                ? widget.filterPageSettings.listFilter.valueNotFoundAlert.color
                    .withOpacity(widget.filterPageSettings.listFilter.valueNotFoundAlert.colorOpacity)
                : Theme.of(context)
                    .primaryColor
                    .withOpacity(widget.filterPageSettings.listFilter.valueNotFoundAlert.colorOpacity),
            fontSize: widget.filterPageSettings.listFilter.valueNotFoundAlert.fontSize,
            letterSpacing: widget.filterPageSettings.listFilter.valueNotFoundAlert.letterSpacing,
            fontWeight: widget.filterPageSettings.listFilter.valueNotFoundAlert.fontWeight,
          ),
        ),
      ),
    );
  }

  //Build List Items
  ListView buildListItems() {
    var source = widget.controller.listItems.getListItems.where((element) => element.visible).toList();
    return ListView.builder(
      itemCount: source.length,
      itemBuilder: (context, index) {
        var item = source[index];
        return widget.customItemBuilder != null
            ? InkWell(
                child: widget.customItemBuilder(context, item.item, item.selected),
                onTap: () {
                  //OnTap Item
                  _onTapItem(item, context);
                },
              )
            : Padding(
                padding: widget.filterPageSettings.buildItemFilter.padding, //General Item Selected Padding
                child: InkWell(
                  onTap: () {
                    //OnTap Item
                    _onTapItem(item, context);
                  },
                  borderRadius: BorderRadius.circular(widget.filterPageSettings.buildItemFilter.circularBorderRadiusItem),
                  child: Padding(
                    padding: widget.filterPageSettings.buildItemFilter.spaceBetweenItems, //General Container Selected Padding
                    child: buildItemDecoration(item, context),
                  ),
                ),
              );
      },
    );
  }

  //BuildvItemvDecoration
  Widget buildItemDecoration(Item item, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.selected
            ? widget.filterPageSettings.buildItemFilter.backgroundSelectedItem != null
                ? widget.filterPageSettings.buildItemFilter.backgroundSelectedItem
                    .withOpacity(widget.filterPageSettings.buildItemFilter.backgroundSelectedItemOpacity)
                : Theme.of(context)
                    .primaryColor
                    .withOpacity(widget.filterPageSettings.buildItemFilter.backgroundSelectedItemOpacity)
            : Colors.transparent,
        border: Border.all(
            color: item.selected
                ? widget.filterPageSettings.buildItemFilter.borderSelectedItem != null
                    ? widget.filterPageSettings.buildItemFilter.borderSelectedItem
                        .withOpacity(widget.filterPageSettings.buildItemFilter.borderSelectedItemOpacity)
                    : Theme.of(context)
                        .primaryColor
                        .withOpacity(widget.filterPageSettings.buildItemFilter.borderSelectedItemOpacity)
                : Colors.transparent,
            width: 0.0),
        borderRadius: BorderRadius.circular(widget.filterPageSettings.buildItemFilter.circularBorderRadiusBackgroundItem),
      ),
      child: Padding(
        padding: widget.filterPageSettings.buildItemFilter.backgroundValuePadding,
        //Content Selected Padding
        child: Column(
          crossAxisAlignment: widget.filterPageSettings.buildItemFilter.crossAxisAlignment,
          children: [
            buildTextItemValue(item, context),
            if (widget.filterPageSettings.buildItemFilter.hasAnimationOnSelectItem)
              buildAnimatedContainerSelectedItem(item, context),
          ],
        ),
      ),
    );
  }

  //Build Text ItemValue
  Widget buildTextItemValue(Item item, BuildContext context) {
    return Padding(
      padding: widget.filterPageSettings.buildItemFilter.valuePadding, //Text Selected Padding
      child: Text(
        item.item.toString(),
        style: TextStyle(
            color: item.selected
                ? widget.filterPageSettings.buildItemFilter.itemValue.color != null
                    ? widget.filterPageSettings.buildItemFilter.itemValue.color
                        .withOpacity(widget.filterPageSettings.buildItemFilter.itemValue.colorOpacity)
                    : Theme.of(context).primaryColor.withOpacity(widget.filterPageSettings.buildItemFilter.itemValue.colorOpacity)
                : null,
            fontWeight: item.selected
                ? widget.filterPageSettings.buildItemFilter.itemValue.fontWeight != null
                    ? widget.filterPageSettings.buildItemFilter.itemValue.fontWeight
                    : FontWeight.w500
                : FontWeight.normal,
            letterSpacing: item.selected ? widget.filterPageSettings.buildItemFilter.itemValue.letterSpacing : 0.0),
      ),
    );
  }

  //Build AnimatedContainer SelectedItem
  Widget buildAnimatedContainerSelectedItem(Item item, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.filterPageSettings.buildItemFilter.animationDurationMilliseconds),
      height: item.selected ? widget.filterPageSettings.buildItemFilter.increaseHeightWhenAnimating : 0.0,
      curve: setCurveAnimation(widget.filterPageSettings.buildItemFilter.curves),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: widget.filterPageSettings.buildItemFilter.animationDurationMilliseconds + 200),
            curve: Curves.fastOutSlowIn,
            alignment: item.selected ? Alignment.center : AlignmentDirectional.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: widget.filterPageSettings.buildItemFilter.animationDurationMilliseconds + 200),
              width: setAnimatedWidth(context),
              curve: Curves.fastOutSlowIn,
              alignment: item.selected ? Alignment.bottomRight : Alignment.bottomLeft,
              child: Icon(
                widget.filterPageSettings.buildItemFilter.iconAnimation.icon,
                color: widget.filterPageSettings.buildItemFilter.iconAnimation.color != null
                    ? widget.filterPageSettings.buildItemFilter.iconAnimation.color
                    : Theme.of(context).primaryColor,
                size: item.selected ? widget.filterPageSettings.buildItemFilter.iconAnimation.size : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Build Unselect All Float ActionButton
  ScaleTransition buildUnselectAll() {
    return ScaleTransition(
      scale: _animationUnselectAll,
      alignment: FractionalOffset.center,
      child: Material(
        color: widget.filterPageSettings.unselectedAll.background
            .withOpacity(widget.filterPageSettings.unselectedAll.backgroundOpacity),
        //elevation: 5.0,
        borderRadius: BorderRadius.circular(widget.filterPageSettings.unselectedAll.borderRadius),
        child: Container(
          width: 45.0,
          height: 45.0,
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.filterPageSettings.unselectedAll.border
                    .withOpacity(widget.filterPageSettings.unselectedAll.borderOpacity)),
            borderRadius: BorderRadius.circular(widget.filterPageSettings.unselectedAll.borderRadius),
          ),
          child: InkWell(
            onTap: () {
              if (_longPressSelectItems) {
                _longPressSelectItems = false;
                _showMoreActions();
                print("Unselect All has been pressed");
                if (widget.controller.getListItems.length > 0) {
                  widget.controller.listItems.selectOrUselecteAll(all: false);
                  //widget.controller.getListItems.forEach((element) => element.selected = false);
                  //widget.controller.listItems.updateList();
                }
              }
            },
            borderRadius: BorderRadius.circular(widget.filterPageSettings.unselectedAll.borderRadius),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.filterPageSettings.unselectedAll.icon != null
                    ? Icon(
                        widget.filterPageSettings.unselectedAll.icon.icon != null
                            ? widget.filterPageSettings.unselectedAll.icon.icon
                            : Icons.clear_all,
                        color: widget.filterPageSettings.unselectedAll.icon.color != null
                            ? widget.filterPageSettings.unselectedAll.icon.color
                            : Colors.white,
                        size: widget.filterPageSettings.unselectedAll.icon.size != null
                            ? widget.filterPageSettings.unselectedAll.icon.size
                            : 25)
                    : Icon(
                        Icons.clear_all,
                        color: Colors.white,
                        size: 25,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Build Select All Float ActionButton
  ScaleTransition buildSelectAll() {
    return ScaleTransition(
      scale: _animationSelectAll,
      alignment: FractionalOffset.center,
      child: Material(
        color:
            widget.filterPageSettings.selectedAll.background.withOpacity(widget.filterPageSettings.selectedAll.backgroundOpacity),

        //elevation: 5.0,
        borderRadius: BorderRadius.circular(widget.filterPageSettings.selectedAll.borderRadius),
        child: Container(
          width: 45.0,
          height: 45.0,
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.filterPageSettings.selectedAll.border
                    .withOpacity(widget.filterPageSettings.selectedAll.borderOpacity)),
            borderRadius: BorderRadius.circular(widget.filterPageSettings.selectedAll.borderRadius),
          ),
          child: InkWell(
            onTap: () {
              if (_longPressSelectItems) {
                _longPressSelectItems = false;
                _showMoreActions();
                print("Select All has been pressed");
                if (widget.controller.getListItems.length > 0) {
                  widget.controller.listItems.selectOrUselecteAll(all: true);
                  // widget.controller.getListItems.forEach((element) => element.selected = true);
                  // widget.controller.listItems.updateList();
                }
              }
            },
            borderRadius: BorderRadius.circular(widget.filterPageSettings.selectedAll.borderRadius),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.filterPageSettings.selectedAll.icon != null
                    ? Icon(
                        widget.filterPageSettings.selectedAll.icon.icon != null
                            ? widget.filterPageSettings.selectedAll.icon.icon
                            : Icons.done_all,
                        color: widget.filterPageSettings.selectedAll.icon.color != null
                            ? widget.filterPageSettings.selectedAll.icon.color
                            : Colors.white,
                        size: widget.filterPageSettings.selectedAll.icon.size != null
                            ? widget.filterPageSettings.selectedAll.icon.size
                            : 25)
                    : Icon(
                        Icons.done_all,
                        color: Colors.white,
                        size: 25,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Build Select Items Float ActionButton
  Material buildSelectItems(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          print('Long Press!');
          if (!_longPressSelectItems) {
            _longPressSelectItems = true;
            _showMoreActions();
          }
        },
        child: Material(
          color: widget.filterPageSettings.selectedButton.background,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(widget.filterPageSettings.selectedButton.borderRadius),
          child: InkWell(
            onTap: () => _pop(context: context),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(widget.filterPageSettings.selectedButton.borderRadius),
                border: widget.filterPageSettings.selectedButton.border != null
                    ? widget.filterPageSettings.selectedButton.border
                        .withOpacity(widget.filterPageSettings.selectedButton.borderOpacity)
                    : Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(widget.filterPageSettings.selectedButton.borderOpacity),
                      ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 15,
                    child: Icon(
                      _longPressSelectItems ? Icons.expand_more : Icons.expand_less,
                      size: 15,
                    ),
                  ),
                  Wrap(
                    spacing: 2,
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5.0), //Text Selected Button Padding
                        child: Text(
                          '${widget.controller.countSelected} ${widget.filterPageSettings.selectedButton.textValue.value != null ? widget.filterPageSettings.selectedButton.textValue.value : widget.controller.countSelected > 1 ? 'items' : 'item'}',
                          textAlign: widget.filterPageSettings.selectedButton.textValue.textAlign,
                          style: TextStyle(
                            color: widget.filterPageSettings.selectedButton.textValue.color != null
                                ? widget.filterPageSettings.selectedButton.textValue.color
                                    .withOpacity(widget.filterPageSettings.selectedButton.textValue.colorOpacity)
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(widget.filterPageSettings.selectedButton.textValue.colorOpacity),
                            fontSize: widget.filterPageSettings.selectedButton.textValue.fontSize,
                            letterSpacing: widget.filterPageSettings.selectedButton.textValue.letterSpacing,
                            fontWeight: widget.filterPageSettings.selectedButton.textValue.fontWeight,
                          ),
                        ),
                      ),
                      Padding(
                        //Icon Selected Button Padding
                        padding: const EdgeInsets.only(left: 0.0, top: 0.0, right: 5.0, bottom: 0.0),
                        child: widget.filterPageSettings.selectedButton.icon != null
                            ? Icon(
                                widget.filterPageSettings.selectedButton.icon.icon != null
                                    ? widget.filterPageSettings.selectedButton.icon.icon
                                    : Icons.check,
                                size: widget.filterPageSettings.selectedButton.icon.size != null &&
                                        widget.filterPageSettings.selectedButton.icon.size > 0
                                    ? widget.filterPageSettings.selectedButton.icon.size
                                    : 25,
                                color: widget.filterPageSettings.selectedButton.icon.color != null
                                    ? widget.filterPageSettings.selectedButton.icon.color
                                    : Theme.of(context).primaryColor,
                              )
                            : Icon(
                                Icons.check,
                                size: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Set Curve to animation
  Curve setCurveAnimation(CurvesType curvesType) {
    switch (curvesType) {
      case CurvesType.bounceIn:
        return Curves.bounceIn;
        break;
      case CurvesType.bounceInOut:
        return Curves.bounceInOut;
        break;
      case CurvesType.bounceOut:
        return Curves.bounceOut;
        break;
      case CurvesType.decelerate:
        return Curves.decelerate;
        break;
      case CurvesType.ease:
        return Curves.ease;
        break;
      case CurvesType.easeIn:
        return Curves.easeIn;
        break;
      case CurvesType.easeInBack:
        return Curves.easeInBack;
        break;
      case CurvesType.easeInCirc:
        return Curves.easeInCirc;
        break;
      case CurvesType.easeInCubic:
        return Curves.easeInCubic;
        break;
      case CurvesType.easeInExpo:
        return Curves.easeInExpo;
        break;
      case CurvesType.easeInOut:
        return Curves.easeInOut;
        break;
      case CurvesType.easeInOutBack:
        return Curves.easeInOutBack;
        break;
      case CurvesType.easeInOutCirc:
        return Curves.easeInOutCirc;
        break;
      case CurvesType.easeInOutCubic:
        return Curves.easeInOutCubic;
        break;
      case CurvesType.easeInOutExpo:
        return Curves.easeInOutExpo;
        break;
      case CurvesType.easeInOutQuad:
        return Curves.easeInOutQuad;
        break;
      case CurvesType.easeInOutQuart:
        return Curves.easeInOutQuart;
        break;
      case CurvesType.easeInOutQuint:
        return Curves.easeInOutQuint;
        break;
      case CurvesType.easeInOutSine:
        return Curves.easeInOutSine;
        break;
      case CurvesType.easeInQuad:
        return Curves.easeInQuad;
        break;
      case CurvesType.easeInQuart:
        return Curves.easeInQuart;
        break;
      case CurvesType.easeInQuint:
        return Curves.easeInQuint;
        break;
      case CurvesType.easeInSine:
        return Curves.easeInSine;
        break;
      case CurvesType.easeInToLinear:
        return Curves.easeInToLinear;
        break;
      case CurvesType.easeOut:
        return Curves.easeOut;
        break;
      case CurvesType.easeOutBack:
        return Curves.easeOutBack;
        break;
      case CurvesType.easeOutCirc:
        return Curves.easeOutCirc;
        break;
      case CurvesType.easeOutCubic:
        return Curves.easeOutCubic;
        break;
      case CurvesType.easeOutExpo:
        return Curves.easeOutExpo;
        break;
      case CurvesType.easeOutQuad:
        return Curves.easeOutQuad;
        break;
      case CurvesType.easeOutQuart:
        return Curves.easeOutQuart;
        break;
      case CurvesType.easeOutQuint:
        return Curves.easeOutQuint;
        break;
      case CurvesType.easeOutSine:
        return Curves.easeOutSine;
        break;
      case CurvesType.elasticIn:
        return Curves.elasticIn;
        break;
      case CurvesType.elasticInOut:
        return Curves.elasticInOut;
        break;
      case CurvesType.elasticOut:
        return Curves.elasticOut;
        break;
      case CurvesType.fastLinearToSlowEaseIn:
        return Curves.fastLinearToSlowEaseIn;
        break;
      case CurvesType.fastOutSlowIn:
        return Curves.fastOutSlowIn;
        break;
      case CurvesType.linear:
        return Curves.linear;
        break;
      case CurvesType.linearToEaseOut:
        return Curves.linearToEaseOut;
        break;
      case CurvesType.slowMiddle:
        return Curves.slowMiddle;
        break;
      default:
        return Curves.fastOutSlowIn;
    }
  }

  //Show more Actions
  void _showMoreActions() {
    int oldValue = widget.controller.countSelectedValue.value;
    if (_longPressSelectItems) {
      widget.controller.updateCountSelected(value: 0);
      _animationController.forward();
      widget.controller.updateCountSelected(value: oldValue);
    } else {
      widget.controller.updateCountSelected(value: 0);
      _animationController.reverse();
      widget.controller.updateCountSelected(value: oldValue);
    }
  }

  //Set width Size to animation
  double setAnimatedWidth(BuildContext context) {
    return MediaQuery.of(context).size.width -
        (widget.filterPageSettings.buildItemFilter.padding.left +
            widget.filterPageSettings.buildItemFilter.padding.right +
            widget.filterPageSettings.buildItemFilter.spaceBetweenItems.left +
            widget.filterPageSettings.buildItemFilter.spaceBetweenItems.right +
            widget.filterPageSettings.buildItemFilter.backgroundValuePadding.left +
            widget.filterPageSettings.buildItemFilter.backgroundValuePadding.right);
  }

  //When the Backbutton is touched
  Future<bool> _requestPop() {
    _enableSearch = false;
    _pop(context: context);
    return Future.value(false);
  }

  //OnTap Item
  void _onTapItem(Item item, BuildContext context) {
    _longPressSelectItems = false;
    _showMoreActions();

    //Update Item
    item.selected = !item.selected;

    widget.controller.item = item;

    if (!widget.multipleSelect) {
      //Unselect all items
      widget.controller.listItems.selectOrUselecteAll(all: false);

      //Select just one item
      widget.controller.listItems.justOneSelected(item);

      //Return to SearchSelectedItems
      _pop(context: context);
    }
  }

  //Clone Controller to return the data when the user cancels
  void cloneController(SearchItem controller) {
    _oldController.filterValue.value = controller.filterValue.value;
    _oldController.itemValue = controller.itemValue?.value != null
        ? ValueNotifier<Item>(Item(controller.itemValue.value.item, controller.itemValue.value.selected))
        : ValueNotifier<Item>(null);

    controller.listItems?.getListItems?.forEach(
      (element) => _oldController.listItems.setListItem(
        Item(element.itemValue.value, element.selectedValue.value),
      ),
    );
  }

  //Setting the search timer
  configureSearchTimer() {
    _longPressSelectItems = false;
    _showMoreActions();

    print('Setting the search timer');
    if (_enableSearch && (_searchTimer?.isActive ?? false)) {
      _searchTimer.cancel();
    }
    _searchTimer = Timer(Duration(milliseconds: _waitingTimeToSearch), () {
      if (_enableSearch && widget.controller.filter != null && widget.controller.filter.length > 0) {
        try {
          if (_lastSearchValue.compareTo(widget.controller.filter) != 0) {
            _tryToRunTheSearch();
            _lastSearchValue = widget.controller.filter ?? '';
          } else {
            print('Filter is equal last search');
          }
        } catch (e) {
          print('Warning: $e');
        }
      } else {
        executeOfflineSearch();
      }
    });
  }

  //Try to run the search
  void _tryToRunTheSearch() async {
    print('Try to run the search');

    if (_enableSearch && !_loading) {
      _loading = true;

      if (widget.onSearch == null) {
        executeOfflineSearch();
        _loading = false;
      } else {
        widget.controller.listItems.clear();
        widget.controller.updateCountSelected(value: 0);
        var result = await widget.onSearch(widget.controller.filter);

        _loading = false;
        if (result != null && _enableSearch) {
          widget.controller.listItems.fillItemsList(items: result);
        }
      }
    }
  }

  //Execute Offline Search
  void executeOfflineSearch() {
    if (_enableSearch && widget.controller.filter != null && widget.controller.filter.length > 0) {
      widget.controller.getListItems
          .where((element) => element.item == widget.controller.filter ? element.visible = true : element.visible = false)
          .toList();
    } else {
      widget.controller.getListItems.where((element) => element.visible = true).toList();
      _lastSearchValue = DateTime.now().millisecondsSinceEpoch.toString();
    }
    widget.controller.listItems.updateList();
  }

  //Return to SearchSelectedItems
  void _pop({BuildContext context, bool cancel = false}) {
    _enableSearch = false;

    Navigator.pop(context, cancel ? _oldController : widget.controller);
  }
}
