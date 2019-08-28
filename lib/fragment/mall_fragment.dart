import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kfc_flutter/view/ImagesAnimation.dart';
import 'package:async/async.dart';

/**
 * 首页 商城
 */
class MallFragment extends StatefulWidget {
  @override
  _MallState createState() => _MallState();
}

class _MallState extends State<MallFragment> {
  final AsyncMemoizer _asyncMemoizer = new AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
            icon: Image.asset(
              "assets/images/arrow_back.png",
              width: ScreenUtil().setWidth(120),
              height: ScreenUtil().setHeight(120),
            ),
            onPressed: null),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                "assets/images/src_common_component_vmallcart_cartbar_img_icon_kf.png",
                width: ScreenUtil().setWidth(96),
                height: ScreenUtil().setHeight(96),
              ),
              onPressed: null)
        ],
        title: Container(
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/src_img_arrow_search.png",
                    width: ScreenUtil().setWidth(120),
                    height: ScreenUtil().setHeight(120)),
                Text(
                  "会员量贩",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(42)),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Colors.grey[200])),
      ),
      body: SafeArea(
          child: FutureBuilder(future: _asyncMemoizer.runOnce(() async {
        return await Future.delayed(Duration(seconds: 2)).then((_){
          return 1;
        });
      }), builder: (context, val) {
        if (val.hasData) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: ScreenUtil().setHeight(400),
                    child: Swiper(
                      onTap: (i) {},
                      controller: SwiperController(),
                      autoplay: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564028655250&di=8cb369e8e7ed268d5cdd619e0c91c274&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F54%2F93%2F16pic_5493004_b.jpg",
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: <Widget>[
                        Image.asset("assets/images/jssrc_img_kgold_bar_bg.png"),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "我的V金",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: ScreenUtil().setSp(42)),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "100",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: ScreenUtil().setSp(58)),
                                  ),
                                  Image.asset(
                                    "assets/images/jssrc_img_icon_v_small.png",
                                    width: ScreenUtil().setWidth(46),
                                    height: ScreenUtil().setHeight(46),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 5,
                  children: List.generate(10, (i) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: CachedNetworkImage(
                                imageUrl:
                                    "https://raw.githubusercontent.com/FOnlyJack/Images/master/imgs/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-07-21%20%E4%B8%8B%E5%8D%887.37.47.png"),
                          ),
                          Expanded(
                              child: Text(
                            "会员量贩",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(24)),
                          ))
                        ],
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: _buildContent(),
                )
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: ImagesAnimation(
                  w: 50,
                  h: 50,
                  entry: ImagesAnimationEntry(
                      1, 5, "assets/images/loading_%s.jpg")),
            ),
          );
        }
      })),
    );
  }
}

Widget _buildContent() {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (BuildContext content, int index) {
          //比如多种类型 用type这里暂时用index
          if (index == 0) {
            return _buildCommonHorizontalList(parentIndex: index); //爆款特惠
          } else if (index == 1) {
            return _buildCommonHorizontalList(parentIndex: index); //精品推荐
          } else if (index == 2) {
            //秒杀
            return secKill();
          }
          if (index == 3) {
            //福利社
            return welfareSociety();
          } else {
            return _buildHorizontalList(parentIndex: index);
          }
        }),
  );
}

/**
 * 爆款特惠 精品推荐
 */
Widget _buildCommonHorizontalList({int parentIndex}) {
  double height = ScreenUtil().setHeight(365);
  var title;
  var longImg;
  if (parentIndex == 0) {
    title = "爆款特惠";
    longImg =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564028655250&di=8cb369e8e7ed268d5cdd619e0c91c274&imgtype=0&src=http%3A%2F%2Fphoto.16pic.com%2F00%2F54%2F93%2F16pic_5493004_b.jpg";
  } else if (parentIndex == 1) {
    title = "精品推荐";
    longImg =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564055098773&di=79269d918400270f9c7af80e906b78ff&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a39258eddb07a8012049ef53b617.jpg%401280w_1l_2o_100sh.jpg";
  }
  return LimitedBox(
    maxHeight: ScreenUtil().setHeight(900),
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/jssrc_img_decoration_left.png",
                width: ScreenUtil().setWidth(348),
                height: ScreenUtil().setHeight(44),
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil().setSp(42),
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/images/jssrc_img_decoration_right.png",
                width: ScreenUtil().setWidth(348),
                height: ScreenUtil().setHeight(44),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ClipRRect(
            child: CachedNetworkImage(
              width: ScreenUtil().width,
              height: ScreenUtil().setHeight(400),
              fit: BoxFit.fill,
              imageUrl: longImg,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext content, int index) {
                  return buildItem(
                    parentSize: height,
                  );
                }))
      ],
    ),
  );
}

/**
 * 爆款特惠 和精品推荐 列表子项
 */
Widget buildItem({double parentSize}) {
  double edgeSize = 8.0;
  double itemSize = parentSize - edgeSize * 2.0;
  return Container(
    padding: EdgeInsets.all(edgeSize),
    child: SizedBox(
      width: itemSize,
      height: itemSize,
      child: ClipRRect(
        child: CachedNetworkImage(
            imageUrl:
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564644485&di=70270571248e0213e806e2ed3e0daf42&imgtype=jpg&er=1&src=http%3A%2F%2Fcp1.douguo.com%2Fupload%2Fcaiku%2F4%2F3%2Fa%2F200_43ebf8b873579d8e1b65bf091d75db9a.jpg"),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}

/**
 * 秒杀
 */
Widget secKill() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/jssrc_img_decoration_left.png",
              width: ScreenUtil().setWidth(348),
              height: ScreenUtil().setHeight(44),
            ),
            Text(
              "秒杀",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: ScreenUtil().setSp(42),
                  fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/jssrc_img_decoration_right.png",
              width: ScreenUtil().setWidth(348),
              height: ScreenUtil().setHeight(44),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: ClipRRect(
          child: CachedNetworkImage(
              width: ScreenUtil().width,
              height: ScreenUtil().setHeight(400),
              fit: BoxFit.fill,
              imageUrl:
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564055820432&di=a0cd27a0a1c2d92b40e1b047f78ebf48&imgtype=0&src=http%3A%2F%2Fimg.aiimg.com%2Fuploads%2Fallimg%2F170606%2F1-1F606105613.jpg"),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      )
    ],
  );
}

/**
 * V金福利社
 */
Widget welfareSociety() {
  double height = ScreenUtil().setHeight(365);
  return LimitedBox(
    maxHeight: ScreenUtil().setHeight(400),
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/jssrc_img_decoration_left.png",
                width: ScreenUtil().setWidth(348),
                height: ScreenUtil().setHeight(44),
              ),
              Text(
                "V金福利社",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil().setSp(42),
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/images/jssrc_img_decoration_right.png",
                width: ScreenUtil().setWidth(348),
                height: ScreenUtil().setHeight(44),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext content, int index) {
                  return buildItem(
                    parentSize: height,
                  );
                }))
      ],
    ),
  );
}

/**
 * 其他
 */
Widget _buildHorizontalList({int parentIndex}) {
  double height = ScreenUtil().setHeight(370);
  return LimitedBox(
      maxHeight: ScreenUtil().setHeight(1210),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/jssrc_img_decoration_left.png",
                  width: ScreenUtil().setWidth(348),
                  height: ScreenUtil().setHeight(44),
                ),
                Text(
                  "热卖",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenUtil().setSp(42),
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/images/jssrc_img_decoration_right.png",
                  width: ScreenUtil().setWidth(348),
                  height: ScreenUtil().setHeight(44),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: ClipRRect(
              child: CachedNetworkImage(
                  width: ScreenUtil().width,
                  height: ScreenUtil().setHeight(400),
                  fit: BoxFit.fill,
                  imageUrl:
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564055239700&di=62c1ca8777b91a08599ed0bdf0a5c1f2&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106eb5652a8956ac7251c94e47dd7.jpg"),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext content, int index) {
                  return _buildItem(
                    parentSize: height,
                  );
                }),
          ))
        ],
      ));
}

/**
 * 其他子项
 */
Widget _buildItem({double parentSize}) {
  double edgeSize = 8.0;
  double itemSize = parentSize - edgeSize * 2.0;
  return Container(
    padding: EdgeInsets.all(edgeSize),
    child: Container(
      width: itemSize,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564049819877&di=fba3c0ed9de6bff21a97c7d1fc8bef42&imgtype=0&src=http%3A%2F%2Fcp1.douguo.com%2Fupload%2Fcaiku%2Fe%2Fd%2Ff%2F200_edbccbf95fe62467bd4d5133b8004e4f.jpeg",
            width: ScreenUtil().setHeight(300),
            height: ScreenUtil().setHeight(300),
            fit: BoxFit.fill,
          ),
          Container(
              padding: EdgeInsets.only(left: 3, right: 3, bottom: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    "美旅万向轮拉杆旅行箱都市",
                    style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "999",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(34)),
                      ),
                      Image.asset(
                        "assets/images/jssrc_img_icon_v_small.png",
                        width: ScreenUtil().setWidth(23),
                        height: ScreenUtil().setHeight(23),
                      ),
                      Text(
                        "+123",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(34)),
                      ),
                      Text(
                        "元",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenUtil().setSp(22)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "2222",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(34)),
                      ),
                      Text(
                        "元",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(22)),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/jssrc_img_waveline_bg.png")))),
        ],
      ),
    ),
  );
}
