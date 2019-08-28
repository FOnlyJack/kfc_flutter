library flutter_tableview;

import 'package:flutter/material.dart';

import 'list_view_item_builder.dart';

/**
 *定义接口
 */
typedef RowCountAtSection = int Function(int section);
typedef ListViewFatherWidgetBuilder = Widget Function(
    BuildContext context, Widget canScrollWidget);
typedef SectionHeaderBuilder = Widget Function(
    BuildContext context, int section);
typedef CellBuilder = Widget Function(
    BuildContext context, int section, int row);
typedef CellHeight = double Function(
    BuildContext context, int section, int row);
typedef SectionHeaderHeight = double Function(
    BuildContext context, int section);

typedef ValueChanged<int> = void Function(int value);

typedef ValueChangedIndex<int> = void Function(int value);

typedef ItemBuilderValue = ListViewItemBuilder Function(ListViewItemBuilder s);

const String ErorrFlagBegin =
    '\n\n\n====================CeilingListView  Error========================\n\n\n\n';

const String ErorrFlagEnd =
    '\n\n\n\n\n==================================================================\n\n\n\n.';

class CeilingListView extends StatefulWidget {
  CeilingListView({
    @required this.sectionCount,
    @required this.rowCountAtSection,
    @required this.sectionHeaderBuilder,
    @required this.cellBuilder,
    @required this.sectionHeaderHeight,
    @required this.cellHeight,
    this.controller,
    this.physics,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(0.0),
    this.cacheExtent = 50.0,
    this.backgroundColor = Colors.transparent,
    this.valueChange,
    this.itemBuilderValue, this.valueChangedIndex,
    Key key
  })  : assert(
          (rowCountAtSection != null),
          '$ErorrFlagBegin function rowCountAtSection could not be null. $ErorrFlagEnd',
        ),
        assert(
          (cellBuilder != null),
          '$ErorrFlagBegin function cellBuilder could not be null. $ErorrFlagEnd',
        ),
        assert(
          (sectionHeaderHeight != null),
          '$ErorrFlagBegin function sectionHeaderHeight could not be null. $ErorrFlagEnd',
        ),
        assert(
          (cellHeight != null),
          '$ErorrFlagBegin function cellHeight could not be null. $ErorrFlagEnd',
        ),super(key:key);

  @override
  _FlutterTableViewState createState() {
    return _FlutterTableViewState();
  }

  /// How many section.
  final int sectionCount;

  /// How many item in each section.
  final RowCountAtSection rowCountAtSection;

  /// You can through sectionHeaderBuilder create section header widget.
  /// Each section has at most one headWidget.
  /// In a special section, if you don't need section header widget, you can return null.
  final SectionHeaderBuilder sectionHeaderBuilder;

  /// You can through cellBuilder create items.
  final CellBuilder cellBuilder;

  /// return each item widget height.
  final CellHeight cellHeight;

  /// return each section header widget height.
  final SectionHeaderHeight sectionHeaderHeight;

  /// see ScrollView controller
  final ScrollController controller;

  /// see ScrollView physics
  final ScrollPhysics physics;

  /// see ScrollView shrinkWrap
  final bool shrinkWrap;

  final EdgeInsetsGeometry padding;

  /// see ScrollView cacheExtent
  final double cacheExtent;

  final Color backgroundColor;

  final ValueChanged<int> valueChange;

  final ValueChangedIndex<int> valueChangedIndex;

  final ItemBuilderValue itemBuilderValue;
}

class _FlutterTableViewState extends State<CeilingListView> {
  ////////////////////////////////////////////////////////////////////
  //                          variables
  ////////////////////////////////////////////////////////////////////
  SectionHeaderModel currentHeaderModel;
  int totalItemCount = 0;
  List<SectionHeaderModel> sectionHeaderList = List();
  List<int> sectionTotalWidgetCountList = List();
  ScrollController scrollController;
  ListView listView;
  bool insideSetStateFlag = false;

  ListViewItemBuilder _itemBuilder;

  ////////////////////////////////////////////////////////////////////
  //                         init function
  ////////////////////////////////////////////////////////////////////
  void _initBaseData() {
    this.totalItemCount = 0;
    this.sectionHeaderList.clear();
    this.sectionTotalWidgetCountList.clear();

    double offsetY = 0;
    for (int section = 0; section < widget.sectionCount; section++) {
      int rowCount = widget.rowCountAtSection(section);
      Widget sectionHeader = widget.sectionHeaderBuilder(context, section);
      double sectionHeight;
      if (sectionHeader != null) {
        sectionHeight = this.widget.sectionHeaderHeight(context, section);
      } else {
        sectionHeight = 0;
      }

      double sectionHeaderY = offsetY;

      offsetY += sectionHeight;

      int sectionWidgetCount = sectionHeader == null ? rowCount : rowCount + 1;
      sectionTotalWidgetCountList.add(sectionWidgetCount);
      this.totalItemCount += sectionWidgetCount;

      for (int row = 0; row < rowCount; row++) {
        offsetY += this.widget.cellHeight(context, section, row);
      }

      SectionHeaderModel model = SectionHeaderModel(
        y: sectionHeaderY,
        sectionMaxY: offsetY,
        height: sectionHeight,
        section: section,
        headerWidget: sectionHeader,
      );
      sectionHeaderList.add(model);
    }
  }

  void _initScrollController() {
    this.scrollController = this.widget.controller;
    if (this.scrollController == null) {
      this.scrollController = ScrollController();
    }

    this.scrollController.addListener(() {
      double offsetY = this.scrollController.offset;

      if (offsetY <= 0.0) {
        this._updateCurrentSectionHeaderModel(null, 0);
      } else {
        int section = 0;
        for (int i = 0; i < this.sectionHeaderList.length; i++) {
          SectionHeaderModel model = this.sectionHeaderList[i];
          if (offsetY >= model.y && offsetY <= model.sectionMaxY) {
            section = i;
            break;
          }
        }

        SectionHeaderModel model = this.sectionHeaderList[section];
        double delta = model.sectionMaxY - this.scrollController.offset;
        double topOffset;
        if (delta >= model.height) {
          topOffset = 0.0;
        } else {
          topOffset = delta - model.height;
        }
        this._updateCurrentSectionHeaderModel(model, topOffset);
      }
    });
  }

  ////////////////////////////////////////////////////////////////////
  //                       create listView
  ////////////////////////////////////////////////////////////////////
  void _createListView() {
    if (this.insideSetStateFlag == false) {
      this._initBaseData();
    }

    this.insideSetStateFlag = false;
    if(_itemBuilder==null){
      _itemBuilder = ListViewItemBuilder(
        // If you want use [jumpTo] or [animateTo], need set scrollController.
        scrollController: this.scrollController,
        rowCountBuilder: (section) => totalItemCount,
        itemsBuilder: (BuildContext context, int section, int index) {
          Widget itemWidget;
          //  转换当前位置的position的item
          RowSectionModel model = this._getRowSectionModel(index);
          double height;
          //多种类型的item显示     如果标记的position是0 并且是悬浮类型的item 显示该widget
          if (model.row == 0 && model.haveHeaderWidget) {
            itemWidget = this.sectionHeaderList[model.section].headerWidget;
            height = this.widget.sectionHeaderHeight(context, model.section);
            widget.valueChange(model.section);
          } else {
            int row = model.haveHeaderWidget == false ? model.row : model.row - 1;
            itemWidget = this.widget.cellBuilder(context, model.section, row);
            height = this.widget.cellHeight(context, model.section, row);
          }

          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height,
              maxHeight: height,
            ),
            child: itemWidget,
          );
        },
      );
      widget.itemBuilderValue(_itemBuilder);
    }

      this.listView = ListView.builder(
          controller: this.scrollController,
          physics: this.widget.physics ?? AlwaysScrollableScrollPhysics(),
          shrinkWrap: this.widget.shrinkWrap,
          cacheExtent: this.widget.cacheExtent,
          itemBuilder: _itemBuilder.itemBuilder,
          itemCount: totalItemCount);

  }

  ////////////////////////////////////////////////////////////////////
  //                      tool function
  ////////////////////////////////////////////////////////////////////
  RowSectionModel _getRowSectionModel(int index) {
    int passCount = 0;
    for (int section = 0;
        section < this.sectionTotalWidgetCountList.length;
        section++) {
      int currentSectionWidgetCount = this.sectionTotalWidgetCountList[section];
      if (index >= passCount && index < passCount + currentSectionWidgetCount) {
        int row = index - passCount;
        bool haveSectionHeaderWidget =
            this.sectionHeaderList[section].headerWidget != null;
        RowSectionModel model = RowSectionModel(
          section: section,
          row: row,
          haveHeaderWidget: haveSectionHeaderWidget,
        );

        return model;
      }

      passCount += currentSectionWidgetCount;
    }
    return null;
  }

  void _updateCurrentSectionHeaderModel(
      SectionHeaderModel model, double topOffset) {
    bool needSetState = false;
    if (model == null) {
      if (this.currentHeaderModel != null) {
        this.currentHeaderModel = null;
        needSetState = true;
      }
    } else if (this.currentHeaderModel == null) {
      this.currentHeaderModel = model;
      this.currentHeaderModel.topOffset = topOffset;
      needSetState = true;
    } else {
      if (model != this.currentHeaderModel) {
        this.currentHeaderModel = model;

        needSetState = true;
      } else if (model.topOffset != topOffset) {
        needSetState = true;
      }

      this.currentHeaderModel.topOffset = topOffset;
    }

    if (needSetState == true) {
      this.insideSetStateFlag = true;
      setState(() {});
    }
  }

  ////////////////////////////////////////////////////////////////////
  //                          life cycle
  ////////////////////////////////////////////////////////////////////

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (this.widget.controller == null) {
      this.scrollController.dispose();
    }
  }

  @override
  void initState() {
    this._initScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._createListView();
    if (this.currentHeaderModel != null &&
        this.currentHeaderModel.headerWidget != null) {
      return Container(
        padding: this.widget.padding,
        color: widget.backgroundColor,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              child: this.listView,
            ),
            //this.currentHeaderModel.topOffset悬浮布局的当前位置  开始位置为0   向上滑动时 0 - >负值  反之相反   也就是动态算Positioned的位置
            Positioned(
              top: this.currentHeaderModel.topOffset,
              left: 0.0,
              right: 0.0,
              height: this.currentHeaderModel.height,
              child: Container(
                color: Colors.white,
                child: this.currentHeaderModel.headerWidget,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: this.widget.padding,
      color: this.widget.backgroundColor,
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            child: this.listView,
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////
//                          model class
////////////////////////////////////////////////////////////////////

class RowSectionModel {
  RowSectionModel({
    @required this.section,
    @required this.row,
    @required this.haveHeaderWidget,
  });

  final int section;
  final int row;
  final bool haveHeaderWidget;
}

class SectionHeaderModel {
  SectionHeaderModel({
    this.y,
    this.sectionMaxY,
    this.height,
    this.section,
    this.headerWidget,
  });

  final double y;
  final double sectionMaxY;
  final double height;
  final int section;
  final Widget headerWidget;

  double topOffset;
}
