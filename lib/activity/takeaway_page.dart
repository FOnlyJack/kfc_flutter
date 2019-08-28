import 'dart:ui';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kfc_flutter/config/rect_getter.dart';
import 'package:kfc_flutter/view/CeilingListView.dart';
import 'package:kfc_flutter/view/list_view_item_builder.dart';
import 'dart:math';

class TakeAwayPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<TakeAwayPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  ScrollController _controllerLeft = ScrollController();
  ScrollController _controllerRight = ScrollController();
  double downY = 0.0;
  double lastDownY = 0.0;
  double lastListLength = 0.0;

  bool isDown = false;

  int sectionCount = 12;

  bool isEdge = true;

  int type = 0;

  ListViewItemBuilder _itemBuilder;
  ListViewItemBuilder b;
  List<int> positions = List();
  int memoryPosition;
  bool states = false;

  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    return InkWell(
      onTap: () {
        print('click section header. -> section:$section');
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: ScreenUtil().setHeight(120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                "assets/images/src_pages_delivery_component_img_headerleft.png"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "商品类型 $section",
                style: TextStyle(
                    color: Color(0xFFd62f35), fontSize: ScreenUtil().setSp(33)),
              ),
            ),
            Image.asset(
                "assets/images/src_pages_delivery_component_img_headerright.png")
          ],
        ),
      ),
    );
  }

  Widget _cellBuilder(BuildContext context, int section, int row) {
    GlobalKey _key = RectGetter.createGlobalKey();
    return InkWell(
      onTap: () {
        print('click cell item. -> section:$section row:$row');
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0x35999999),
                  offset: Offset(3.0, 3.0),
                  blurRadius: 5,
                  spreadRadius: 2.0),
              BoxShadow(color: Color(0xFFe9e9e9), offset: Offset(1.0, 1.0)),
              BoxShadow(color: Colors.white)
            ],
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Color(0xFFf5f5f5), width: 1)),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Image.asset("assets/images/src_pages_delivery_home_img_type4.png"),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "超级全家桶",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF323232),
                        fontSize: ScreenUtil().setSp(38)),
                  ),
                  Text(
                    "123.0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFd62f35),
                        fontSize: ScreenUtil().setSp(33)),
                  ),
                  Container(
                    width: 100,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        AnimatedPositioned(
                            right: states ? 70 : 0,
                            child: AnimatedOpacity(
                              opacity: states ? 1 : 0,
                              duration: Duration(milliseconds: 400),
                              child: GestureDetector(
                                child: Image.asset(
                                  "assets/images/src_pages_delivery_component_img_sub.png",
                                  width: ScreenUtil().setWidth(78),
                                  height: ScreenUtil().setHeight(78),
                                ),
                                onTap: () {
                                  setState(() {
                                    states = !states;
                                  });
                                  print("================");
                                },
                              ),
                              curve: Curves.fastOutSlowIn,
                            ),
                            duration: Duration(milliseconds: 400)),
                        AnimatedPositioned(
                            right: states ? 35 : 0,
                            child: AnimatedOpacity(
                              opacity: states ? 1 : 0,
                              duration: Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: GestureDetector(
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: Color(0xFF323232),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(42)),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              curve: Curves.fastOutSlowIn,
                            ),
                            duration: Duration(milliseconds: 400)),
                        GestureDetector(
                          child: RectGetter(
                            key: _key,
                            child: Image.asset(
                              "assets/images/src_pages_delivery_component_img_add.png",
                              width: ScreenUtil().setWidth(78),
                              height: ScreenUtil().setHeight(78),
                            ),
                          ),
                          onTapDown: (detail) {
//                            print("add$states d:${detail.globalPosition.dy}");
                            setState(() {
                              states = !states;
                            });
                            //购物车动画
//                            RenderBox object = RectGetter.getRectFromKey(_key);
//                            var offset = object
//                                .localToGlobal(Offset(0.0, object.size.height));
//                            final RelativeRect position = RelativeRect.fromLTRB(
//                                detail.globalPosition.dx, //取点击位置坐弹出x坐标
//                                offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
//                                detail.globalPosition.dx,
//                                offset.dy);

                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  double _sectionHeaderHeight(BuildContext context, int section) {
    return ScreenUtil().setHeight(100);
  }

  double _cellHeight(BuildContext context, int section, int row) {
    return ScreenUtil().setHeight(350);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    scrollController.dispose();
    _controllerLeft.dispose();
    _controllerRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);

    if (_itemBuilder == null) {
      _itemBuilder = ListViewItemBuilder(
        // If you want use [jumpTo] or [animateTo], need set scrollController.
        scrollController: _controllerLeft,
        rowCountBuilder: (section) => sectionCount,
        itemsBuilder: (BuildContext context, int section, int index) {
          if (positions.length > 0) {
            if (index > positions.last) {
              positions.removeAt(0);
              positions.add(index);
            } else if (index < positions.first) {
              positions.removeLast();
              positions.insert(0, index);
            }
          } else {
            memoryPosition = index;
          }

          return InkWell(
            onTap: () {
              b.animateTo(0, index * 6,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              color: type != index ? Color(0xFFf5f5f5) : Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/micon_coffee.png",
                    width: ScreenUtil().setWidth(99),
                    height: ScreenUtil().setHeight(99),
                  ),
                  Text(
                    "$section桶$index",
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Divider(
                      height: 1,
                      color: Color(0xFFe1e1e1),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
    return Material(
      color: Colors.white,
      child: SafeArea(
          child: NotificationListener(
              onNotification: (ScrollUpdateNotification s) {
                print(s.metrics.pixels);
              },
              child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (BuildContext context, bool b) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFd62f35),
                            size: 23,
                          ),
                          onPressed: () {},
                        ),
                        title: Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/jssrc_img_icon_address2.png",
                                height: ScreenUtil().setHeight(42),
                                width: ScreenUtil().setWidth(35),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "沙河北大桥沙河地铁五号线(根据地)",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Color(0xFFd62f35),
                                            fontSize: ScreenUtil().setSp(44)),
                                      ),
                                      Text(
                                        "沙河北大桥沙河地铁五号线(根据地)",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: ScreenUtil().setSp(31)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                  "assets/images/src_pages_delivery_component_header_arrow_down.png",
                                  height: ScreenUtil().setHeight(28),
                                  width: ScreenUtil().setWidth(22))
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/images/src_pages_delivery_component_header_pin.png",
                              width: ScreenUtil().setWidth(44),
                              height: ScreenUtil().setHeight(44),
                            ),
                          )
                        ],
                        expandedHeight: ScreenUtil().setHeight(390),
                        floating: false,
                        pinned: true,
                        snap: false,
                        elevation: 0,
                        primary: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            margin: EdgeInsets.only(top: 50),
                            color: Colors.white,
                            child: SizedBox(
                              child: Swiper(
                                onTap: (i) {},
                                controller: SwiperController(),
                                autoplay: false,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564028655250&di=8cb369e8e7ed268d5cdd619e0c91c274&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F54%2F93%2F16pic_5493004_b.jpg",
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                  );
                                },
                                pagination: SwiperPagination(
                                    builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.grey,
                                )),
                                itemCount: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                          pinned: true, //是否固定在顶部
                          floating: false,
                          delegate: _SliverAppBarDelegate(
                              minHeight: ScreenUtil().setHeight(120), //收起的高度
                              maxHeight: ScreenUtil().setHeight(120), //展开的最大高度
                              child: isEdge
                                  ? Container(
                                      padding: EdgeInsets.only(left: 16),
                                      color: Colors.white,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    height: ScreenUtil()
                                                        .setHeight(80),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFFf5f5f5),
                                                            width: 1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/images/src_pages_delivery_component_headermenu_time.png",
                                                          width: ScreenUtil()
                                                              .setWidth(48),
                                                          height: ScreenUtil()
                                                              .setHeight(48),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6),
                                                          child: Text(
                                                            "预约",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF404040),
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: ScreenUtil()
                                                        .setHeight(80),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFFf5f5f5),
                                                            width: 1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/images/src_pages_delivery_component_headermenu_coffee.png",
                                                          width: ScreenUtil()
                                                              .setWidth(48),
                                                          height: ScreenUtil()
                                                              .setHeight(48),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6),
                                                          child: Text(
                                                            "咖啡",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF404040),
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                  height: ScreenUtil()
                                                      .setHeight(80),
                                                  width: ScreenUtil()
                                                      .setWidth(200),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0x35999999),
                                                            offset: Offset(
                                                                3.0, 3.0),
                                                            blurRadius: 5,
                                                            spreadRadius: 3.0),
                                                        BoxShadow(
                                                            color: Color(
                                                                0xFFe9e9e9),
                                                            offset: Offset(
                                                                1.0, 1.0)),
                                                        BoxShadow(
                                                            color: Colors.white)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20)),
                                                      border: Border.all(
                                                          color:
                                                              Color(0xFFf5f5f5),
                                                          width: 1)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/images/src_pages_delivery_component_headermenu_card.png",
                                                        width: ScreenUtil()
                                                            .setWidth(48),
                                                        height: ScreenUtil()
                                                            .setHeight(48),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6),
                                                        child: Text(
                                                          "卡包",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF404040),
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ))
                                        ],
                                      ),
                                    )
                                  : Container(
                                      decoration: new BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Color(0x99999999),
                                                width: 1)),
                                        // 边色与边宽度
// 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x35999999),
                                              offset: Offset(3.0, 3.0),
                                              blurRadius: 5,
                                              spreadRadius: 3.0),
                                          BoxShadow(
                                              color: Color(0xFFe9e9e9),
                                              offset: Offset(1.0, 1.0)),
                                          BoxShadow(color: Colors.white)
                                        ],
                                      ),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    height: ScreenUtil()
                                                        .setHeight(80),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/images/src_pages_delivery_component_headermenu_time.png",
                                                          width: ScreenUtil()
                                                              .setWidth(48),
                                                          height: ScreenUtil()
                                                              .setHeight(48),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6),
                                                          child: Text(
                                                            "预约",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF404040),
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: ScreenUtil()
                                                        .setHeight(80),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/images/src_pages_delivery_component_headermenu_coffee.png",
                                                          width: ScreenUtil()
                                                              .setWidth(48),
                                                          height: ScreenUtil()
                                                              .setHeight(48),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6),
                                                          child: Text(
                                                            "咖啡",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF404040),
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                  height: ScreenUtil()
                                                      .setHeight(80),
                                                  width: ScreenUtil()
                                                      .setWidth(200),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/images/src_pages_delivery_component_headermenu_card.png",
                                                        width: ScreenUtil()
                                                            .setWidth(48),
                                                        height: ScreenUtil()
                                                            .setHeight(48),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6),
                                                        child: Text(
                                                          "卡包",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF404040),
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ))
                                        ],
                                      ),
                                    )))
                    ];
                  },
                  body:Container(
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Listener(
                              onPointerDown: (PointerDownEvent event) {
                                downY = event.position.distance;
                              },
                              onPointerMove: (event) {
                                var position = event.position.distance;
                                var detal = position - lastDownY;
                                if (detal != null && detal > 0) {
                                  isDown = true;
                                } else {
                                  isDown = false;
                                }
                                lastDownY = position;
                              },
                              child: NotificationListener(
                                  onNotification: (s) {
                                    if (s is ScrollUpdateNotification) {
                                      print("==============");
                                      ScrollUpdateNotification c = s;
                                      var metrics = c.metrics;
                                      if (metrics != null) {
                                        if (metrics.pixels >= 112) {
                                          scrollController
                                              .jumpTo(metrics.pixels);
                                          isEdge = false;
                                        } else if (metrics.pixels < 112 &&
                                            metrics.pixels > 0) {
                                          if (isDown) {
                                            scrollController.animateTo(
                                                metrics.pixels,
                                                duration:
                                                Duration(milliseconds: 200),
                                                curve: Curves.linear);
                                          } else {
                                            scrollController
                                                .jumpTo(metrics.pixels);
                                          }
                                        } else if (metrics.pixels <= 0.0) {
                                          isEdge = true;
                                        }
                                      }
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        setState(() {
                                          this.isEdge = isEdge;
                                        });
                                      });
                                    } else if (s is ScrollNotification) {
                                      if (positions.length == 0) {
                                        for (int i = 0;
                                        i <= memoryPosition;
                                        i++) {
                                          positions.add(i);
                                        }
                                      }
                                    }
                                    return false;
                                  },
                                  child: SizedBox(
                                    width: ScreenUtil().setWidth(200),
                                    height: ScreenUtil().height,
                                    child: NestedScrollView(
                                      controller: ScrollController(),
                                      headerSliverBuilder:
                                          (BuildContext context,
                                          bool innerBoxIsScrolled) {
                                        return <Widget>[
                                          SliverToBoxAdapter(
                                            child: Text(""),
                                          )
                                        ];
                                      },
                                      body: FutureBuilder(
                                          future: Future.delayed(
                                              Duration(milliseconds: 1500), () {
                                            return "模拟数据加载";
                                          }),
                                          builder: (context, val) {
                                            if (val.hasData) {
                                              return ListView.builder(
                                                cacheExtent: 0,
                                                itemBuilder:
                                                _itemBuilder.itemBuilder,
                                                itemCount:
                                                _itemBuilder.itemCount,
                                                controller: _controllerLeft,
                                              );
                                            } else {
                                              return Text("加载中...");
                                            }
                                          }),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Listener(
                                onPointerDown: (PointerDownEvent event) {
                                  downY = event.position.distance;
                                },
                                onPointerMove: (event) {
                                  var position = event.position.distance;
                                  var detal = position - lastDownY;
                                  if (detal != null && detal > 0) {
                                    isDown = true;
                                  } else {
                                    isDown = false;
                                  }
                                  lastDownY = position;
                                },
                                child: NotificationListener(
                                    onNotification: (s) {
                                      if (s is ScrollUpdateNotification) {
                                        ScrollUpdateNotification c = s;
                                        var metrics = c.metrics;
                                        if (metrics != null) {
                                          if (metrics.pixels >= 112) {
                                            scrollController.jumpTo(112);
                                            isEdge = false;
                                          } else if (metrics.pixels < 112) {
                                            if (isDown) {
                                              scrollController.animateTo(
                                                  metrics.pixels,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.linear);
                                            } else {
                                              scrollController
                                                  .jumpTo(metrics.pixels);
                                            }

                                            if (metrics.pixels <= 0.0) {
                                              isEdge = true;
                                            }
                                          }
                                        }
                                        Future.delayed(
                                            Duration(milliseconds: 200), () {
                                          setState(() {
                                            this.isEdge = isEdge;
                                          });
                                        });
                                      } else if (s is ScrollEndNotification) {
                                        if (positions.length > 0) {
                                          int first = positions.first;
                                          int last = positions.last;
                                          if (type > last || type < first) {
                                            _itemBuilder.animateTo(0, type,
                                                duration:
                                                Duration(milliseconds: 200),
                                                curve: Curves.linear);
                                          }
                                        } else {
                                          for (int i = 0;
                                          i <= memoryPosition;
                                          i++) {
                                            positions.add(i);
                                          }
                                        }
                                      }
                                      return false;
                                    },
                                    child: NestedScrollView(
                                      controller: ScrollController(),
                                      headerSliverBuilder:
                                          (BuildContext context,
                                          bool innerBoxIsScrolled) {
                                        return <Widget>[
                                          SliverToBoxAdapter(
                                            child: Text(""),
                                          )
                                        ];
                                      },
                                      body: FutureBuilder(
                                          future: Future.delayed(
                                              Duration(milliseconds: 1500), () {
                                            return "模拟加载数据";
                                          }),
                                          builder: (context, val) {
                                            if (val.hasData) {
                                              return CeilingListView(
                                                // ignore: missing_return
                                                itemBuilderValue:
                                                    (ListViewItemBuilder s) {
                                                  if (s != null && b == null) {
                                                    this.b = s;
                                                  }
                                                },
                                                controller: _controllerRight,
                                                physics:
                                                BouncingScrollPhysics(),
                                                sectionCount: sectionCount,
                                                rowCountAtSection:
                                                    (int section) {
                                                  return 5;
                                                },
                                                valueChange: (section) {
                                                  type = section;
                                                },
                                                //每一个组下有多少个
                                                sectionHeaderBuilder:
                                                _sectionHeaderBuilder,
                                                //组widget
                                                cellBuilder: _cellBuilder,
                                                sectionHeaderHeight:
                                                _sectionHeaderHeight,
                                                cellHeight: _cellHeight,
                                              );
                                            } else {
                                              return Text("加载中...");
                                            }
                                          }),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )))),
    );
  }
}

typedef ValueChanged<int> = void Function(int first, int last);

class MySliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  final ValueChanged<int> _valueChange;

  MySliverChildBuilderDelegate(
    Widget Function(BuildContext, int) builder,
    this._valueChange, {
    int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : super(builder,
            childCount: childCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries);

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    if (_valueChange != null) {
      _valueChange(firstIndex, lastIndex);
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
