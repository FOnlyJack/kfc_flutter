import 'dart:io';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kfc_flutter/activity/check_page.dart';
import 'package:kfc_flutter/activity/city_select_custom_header.dart';
import 'package:kfc_flutter/activity/login_activity.dart';
import 'package:kfc_flutter/activity/takeaway_page.dart';
import 'package:kfc_flutter/bean/ChangeNotifiBean.dart';
import 'package:kfc_flutter/bean/HomePageBean.dart';
import 'package:kfc_flutter/net/service_method.dart';
import 'package:kfc_flutter/view/ImagesAnimation.dart';
import 'package:kfc_flutter/view/PopRoute.dart';
import 'package:provider/provider.dart';

/**
 * 首页
 */
class HomeFragment extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin {
  final _scrollviewController = ScrollController();
  final _scrollviewControllerorizontal = ScrollController();
  final AsyncMemoizer _asyncMemoizer = new AsyncMemoizer();
  var startValue = 0.0;
  var endValue = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollviewControllerorizontal.addListener(() {
      if (_scrollviewControllerorizontal.offset >=
          _scrollviewControllerorizontal.position.maxScrollExtent) {
        startValue = _scrollviewControllerorizontal.position.maxScrollExtent;
      } else if (_scrollviewControllerorizontal.offset <= 0.0) {
        startValue = 0.0;
      } else {
        startValue = _scrollviewControllerorizontal.offset;
      }
      endValue = _scrollviewControllerorizontal.position.maxScrollExtent;
      Provider.of<ChangeNotifiBean>(context).scrollStartValue = startValue;
      Provider.of<ChangeNotifiBean>(context).scrollEndValue = endValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(future: _asyncMemoizer.runOnce(() async {
      return await request('homePage');
    }), builder: (context, val) {
      if (val.hasData) {
        HomePageBean homePageBean = new HomePageBean(val.data);
        AbdoMen abdomen = homePageBean.data.abdomen;
        var DeliVeryList = abdomen.delivery;
        var slideList = abdomen.slide;
        var _listTop =
            DeliVeryList.getRange(0, DeliVeryList.length ~/ 2).toList();
        var _listButtom = DeliVeryList.getRange(
                DeliVeryList.length ~/ 2, DeliVeryList.length.toInt())
            .toList();
        return Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          margin: EdgeInsets.only(top: 20),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(
                controller: _scrollviewController,
                slivers: <Widget>[
                  topTitle(context),
                  pleseLogin(context),
                  takeawayMeal(context),
                  gridType(
                    deliVeryListTop: _listTop,
                    deliVeryListBottom: _listButtom,
                    controller: _scrollviewControllerorizontal,
                  ),
                  banner(slideList: slideList),
                  _buildContent(abdomen: abdomen),
                ],
              )),
        );
      } else {
        return Container(
          color: Colors.white,
          child: Center(
            child: ImagesAnimation(
                w: 50,
                h: 50,
                entry:
                    ImagesAnimationEntry(1, 5, "assets/images/loading_%s.jpg")),
          ),
        );
      }
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/**
 * 轮播
 */
Widget banner({List<Slide> slideList}) {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: ScreenUtil().setHeight(350),
      child: Swiper(
        onTap: (i) {},
        controller: SwiperController(),
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: slideList[index].url,
            ),
          );
        },
        itemCount: slideList.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    ),
  );
}

/**
 * 7种类型主体列表数据
 */
Widget _buildContent({AbdoMen abdomen}) {
  BookWorm bookworm = abdomen.bookworm;
  KMusic kmusic = abdomen.K_MUSIC;
  Delicious delicious = abdomen.delicious;
  Enjoy enjoy = abdomen.enjoy;
  Major major = abdomen.major;
  Vip vip = abdomen.vip;
  WholeSale wholesale = abdomen.wholesale;
  var titleName;
  var topImage;
  return SliverToBoxAdapter(
    child: Container(
      color: Colors.white,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Image.asset("assets/images/home_bg_view2shad.png");
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (BuildContext content, int index) {
            if (index == 0) {
              titleName = "小书迷王国";
              topImage = bookworm.bookwormbaseimg;
            } else if (index == 1) {
              titleName = "K-Music";
              topImage = kmusic.K_MUSICBaseImg;
            } else if (index == 2) {
              titleName = "美味尝鲜";
              topImage = delicious.deliciousbaseimg;
            } else if (index == 3) {
              titleName = "商城•V享好物";
              topImage = enjoy.enjoybaseimg;
            } else if (index == 4) {
              titleName = "商城•大牌超值汇";
              topImage = major.majorbaseimg;
            } else if (index == 5) {
              titleName = "WOW会员";
              topImage = vip.vipbaseimg;
            } else if (index == 6) {
              titleName = "商城•会员量贩";
              topImage = wholesale.wholesalebaseimg;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/kfc20190325_1_n_line.png",
                        width: ScreenUtil().setWidth(36),
                        height: ScreenUtil().setHeight(8),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "$titleName",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(34),
                              color: Colors.black),
                        ),
                      ),
                      Image.asset(
                        "assets/images/kfc20190325_1_n_line.png",
                        width: ScreenUtil().setWidth(36),
                        height: ScreenUtil().setHeight(8),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  child: CachedNetworkImage(imageUrl: topImage),
                  onTap: () => {},
                ),
                _buildHorizontalList(
                    parentIndex: index,
                    bookworm: bookworm,
                    kmusic: kmusic,
                    delicious: delicious,
                    enjoy: enjoy,
                    major: major,
                    vip: vip,
                    wholesale: wholesale)
              ],
            );
          }),
    ),
  );
}

/**
 * 列表水平滑动子项
 */
Widget _buildHorizontalList(
    {int parentIndex,
    BookWorm bookworm,
    KMusic kmusic,
    Delicious delicious,
    Enjoy enjoy,
    Major major,
    Vip vip,
    WholeSale wholesale}) {
  double height = ScreenUtil().setHeight(320);
  double edgeSize = 4.0;
  double itemSize = height - edgeSize * 2.0;
  /**
   * 多种类型的横向子列表布局
   */
  if (parentIndex == 0) {
    List<BookwormImgs> BookwormimgsList = bookworm.bookwormimgs;
    return SizedBox(
      height: height + height / 13,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: BookwormimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: BookwormimgsList[index].url,
                      ),
                      Text(
                        BookwormimgsList[index].name,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 1) {
    List<KMusicImgs> KMusicImgsList = kmusic.K_MUSICImgs;
    return SizedBox(
      height: height + height / 13,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: KMusicImgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.center,
                        child: CachedNetworkImage(
                          imageUrl: KMusicImgsList[index].url,
                        ),
                      ),
                      Text(KMusicImgsList[index].name,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Colors.black))
                    ],
                  ),
                ),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 2) {
    List<DeliciousImgs> DeliciousimgsList = delicious.deliciousimgs;
    return SizedBox(
      height: height + height / 2,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: DeliciousimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                    width: itemSize,
                    height: itemSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: DeliciousimgsList[index].url,
                        ),
                        Text(DeliciousimgsList[index].name,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.black))
                      ],
                    )),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 3) {
    List<EnjoyImgs> EnjoyimgsList = enjoy.enjoyimgs;
    return SizedBox(
      height: height + height / 6,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: EnjoyimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                    width: itemSize,
                    height: itemSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: EnjoyimgsList[index].url,
                        ),
                        Text(EnjoyimgsList[index].name,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.black))
                      ],
                    )),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 4) {
    List<MajorImgs> MajorimgsList = major.majorimgs;
    return SizedBox(
      height: height + height / 4,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: MajorimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: MajorimgsList[index].url,
                        fit: BoxFit.fill,
                        width: itemSize,
                        height: itemSize,
                      ),
                      Text(MajorimgsList[index].name,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.red,
                              width: 1,
                            )),
                            child: Text("券后价",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Colors.red)),
                          ),
                          Text("999",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                  color: Colors.red)),
                          Image.asset(
                            "assets/images/kfc20190325_headv.png",
                            width: ScreenUtil().setWidth(20),
                            height: ScreenUtil().setHeight(20),
                          ),
                          Text("+999元",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                  color: Colors.red)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 5) {
    List<VipImgs> VipimgsList = vip.vipimgs;
    return SizedBox(
      height: height + height / 8,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: VipimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: itemSize,
                      height: itemSize,
                      child: CachedNetworkImage(
                        imageUrl: VipimgsList[index].url,
                      ),
                    ),
                    Text(VipimgsList[index].name,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Colors.black)),
                  ],
                ),
              ),
              onTap: () => {},
            );
          }),
    );
  } else if (parentIndex == 6) {
    List<WholeSaleImgs> WholesaleimgsList = wholesale.wholesaleimgs;
    return SizedBox(
      height: height + height / 13,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: WholesaleimgsList.length,
          itemBuilder: (BuildContext content, int index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(edgeSize),
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: CachedNetworkImage(
                      imageUrl: WholesaleimgsList[index].url,
                      fit: BoxFit.fill,
                      width: itemSize,
                      height: itemSize,
                    ),
                  ),
                ),
              ),
              onTap: () => {},
            );
          }),
    );
  }
}

/**
 * 十种分类 grid
 */
Widget gridType(
    {List<DeliVery> deliVeryListTop,
    List<DeliVery> deliVeryListBottom,
    ScrollController controller}) {
  return SliverToBoxAdapter(
      child: Padding(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            height: ScreenUtil().setHeight(445),
            child: CustomScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: List.generate(deliVeryListTop.length, (i) {
                          var index = 8.0;
                          return SizedBox(
                            width: ScreenUtil().setWidth(260) - index * 2,
                            height: ScreenUtil().setHeight(260) - index * 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: deliVeryListTop[i].url,
                                  width: ScreenUtil().setWidth(130),
                                  height: ScreenUtil().setHeight(130),
                                ),
                                Text(deliVeryListTop[i].name)
                              ],
                            ),
                          );
                        }),
                      ),
                      Row(
                        children: List.generate(deliVeryListBottom.length, (i) {
                          var index = 8.0;
                          return SizedBox(
                            width: ScreenUtil().setWidth(260) - index * 2,
                            height: ScreenUtil().setHeight(260) - index * 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CachedNetworkImage(
                                    imageUrl: deliVeryListBottom[i].url,
                                    width: ScreenUtil().setWidth(130),
                                    height: ScreenUtil().setHeight(130)),
                                Text(deliVeryListBottom[i].name)
                              ],
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
            )),
        Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/kfc20190325_grid_line1.png",
              width: ScreenUtil().setWidth(68),
              height: ScreenUtil().setHeight(8),
            ),
            Consumer<ChangeNotifiBean>(builder: (context, model, _) {
              return Padding(
                padding: EdgeInsets.only(
                    left: (model.scrollStartValue / model.scrollEndValue) *
                        ScreenUtil().setWidth(20)),
                child: Image.asset(
                  "assets/images/kfc20190325_grid_line2.png",
                  width: ScreenUtil().setWidth(48),
                  height: ScreenUtil().setHeight(8),
                ),
              );
            })
          ],
        ),
      ],
    ),
  ));
}

/**
 * 外卖点餐
 */
Widget takeawayMeal(BuildContext context) {
  return SliverToBoxAdapter(
    child:GestureDetector(
      child:  Container(
        margin: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/kfc20190325_delivery.jpg",
              width: ScreenUtil().setWidth(480),
              height: ScreenUtil().setHeight(260),
            ),
            Padding(padding: EdgeInsets.only(left: 9, right: 9)),
            Image.asset(
              "assets/images/kfc20190325_preorder.jpg",
              width: ScreenUtil().setWidth(480),
              height: ScreenUtil().setHeight(260),
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TakeAwayPage()),
        );
      },
    ),
  );
}

/**
 * 请登录 会员码
 */
Widget pleseLogin(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              spreadRadius: 1.0),
        ],
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 14),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "我的",
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(28)),
                  ),
                  Image.asset(
                    "assets/images/kfc20190325_headv.png",
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setHeight(40),
                  ),
                  Text(
                    "金",
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(28)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginActivity()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "请登录",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(42),
                            color: Colors.black),
                      ),
                      Image.asset(
                        "assets/images/kfc20190325_headloginline_dark.png",
                        width: ScreenUtil().setWidth(19),
                        height: ScreenUtil().setHeight(40),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckPage()),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/kfc20190325_headvipcode.png",
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setHeight(150),
                    ),
                    Text(
                      "会员码",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(28)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/kfc20190325_headcardbag.png",
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setHeight(150),
                    ),
                    Text(
                      "卡包",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(28)),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/kfc20190325_headcoupon.png",
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(150),
                  ),
                  Text(
                    "优惠券",
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(28)),
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    ),
  );
}

/**
 * 顶部城市切换
 */
Widget topTitle(BuildContext context) {
  return SliverToBoxAdapter(
      child: Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: "",
          placeholder: (context, url) => Image.asset(
                "assets/images/kfc20190325_head.png",
                width: ScreenUtil().setWidth(90),
                height: ScreenUtil().setHeight(90),
              ),
          errorWidget: (context, url, error) => Image.asset(
                "assets/images/kfc20190325_head.png",
                width: ScreenUtil().setWidth(90),
                height: ScreenUtil().setHeight(90),
              ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Text(
                      "北京市",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(42),
                          color: Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(left: 7.5)),
                    Image.asset(
                      "assets/images/kfc20190325_head_citydown.png",
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setHeight(19),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySelectCustomHeaderRoute()),
                  );
                },
              ),
              Text(
                "沙河物美 约3.01公里",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(26), color: Colors.black),
              )
            ],
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              "assets/images/kfc20190325_homehead_sign.png",
              width: ScreenUtil().setWidth(67),
              height: ScreenUtil().setHeight(70),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Image.asset(
                "assets/images/kfc20190325_sms.png",
                width: ScreenUtil().setWidth(70),
                height: ScreenUtil().setHeight(60),
              ),
            ),
            GestureDetector(
              child: Image.asset(
                "assets/images/kfc20190325_homehead_more.png",
                height: ScreenUtil().setHeight(80),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PopRoute(
                    child: Popup(
                      child: Container(
                        width: 100,
                        height: 130,
                        padding: EdgeInsets.only(left: 5, bottom: 30, top: 15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                alignment: AlignmentDirectional.center,
                                image: AssetImage(
                                    "assets/images/kfc20190325_headmorebg.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/kfc20190325_headmore_scan.jpg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  Text(
                                    "扫一扫啊",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                color: Colors.grey[700],
                                height: 0,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/kfc20190325_headmore_service.jpg",
                                      width: 16,
                                      height: 16),
                                  Text(
                                    "客服人员",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                color: Colors.grey[700],
                                height: 0,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                      "assets/images/kfc20190325_headmore_store.jpg",
                                      width: 16,
                                      height: 16),
                                  Text(
                                    "附近门店",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      left: MediaQuery.of(context).size.width - 110,
                      top: 60,
                      onClick: () {
                        print("exit");
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ))
      ],
    ),
  ));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      //边缘效果
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
