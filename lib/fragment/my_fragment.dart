import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 首页 我的
 */
class MyFragment extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
      Container(
              color: Color(0xFFf6f6f6),
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x35999999),
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 5,
                                  spreadRadius: 3.0),
                              BoxShadow(
                                  color: Color(0xFFe9e9e9), offset: Offset(1.0, 1.0)),
                              BoxShadow(color:Colors.white)
                            ],
                          ),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          margin: EdgeInsets.only(top: 260),
                          height: ScreenUtil().setHeight(150),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "WOW徽章",
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: ScreenUtil().setSp(42)),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/src_page_setting_img_commonwealicon3.png",
                                        width: ScreenUtil().setWidth(52),
                                        height: ScreenUtil().setHeight(56),
                                      ),
                                      Image.asset(
                                        "assets/images/src_page_setting_img_commonweal_dark.png",
                                        width: ScreenUtil().setWidth(52),
                                        height: ScreenUtil().setHeight(56),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "查看",
                                        style: TextStyle(
                                            color: Color(0xFFc5c5c5),
                                            fontSize: ScreenUtil().setSp(28)),
                                      ),
                                      Padding(padding: EdgeInsets.only(right: 8)),
                                      Image.asset(
                                        "assets/images/jssrc_page_setting_img_arrow_right.png",
                                        width: ScreenUtil().setWidth(44),
                                        height: ScreenUtil().setHeight(24),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child:Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),

                          child:  ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: ScreenUtil().setHeight(140),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: CustomListItem(
                                    leftIcon: Image.asset(
                                        "assets/images/src_img_user_icon1.png"),
                                    rightIcon: Image.asset(
                                      "assets/images/jssrc_page_setting_img_arrow_right.png",
                                      width: ScreenUtil().setWidth(44),
                                      height: ScreenUtil().setHeight(24),
                                    ),
                                    title: "标题",
                                    rightDescription: "描述",
                                  ),
                                );
                              },
                              separatorBuilder: (_, index) => Container(
                                  decoration: index ==4? BoxDecoration(
                                    border: Border(top:BorderSide(color: Color(0xFFeaeaea),width: 1) ,bottom:BorderSide(color: Color(0xFFf6f6f6),width: 4) ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFFf4f4f4),
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0),
                                      BoxShadow(color:Color(0xFFf6f6f6))
                                    ],
                                  ):null,
                                  height: index == 4 ? 10 : 1,
                                  color: index == 4 ?null : Color(0xFFe8e8e8)),
                              itemCount: 8),
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/images/jssrc_img_user_header_bg.png",
                    width: ScreenUtil().width,
                    height: ScreenUtil().setHeight(600),
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/src_img_arrow_backwhite.png",
                          width: ScreenUtil().setWidth(60),
                          height: ScreenUtil().setHeight(60),
                        ),
                        Image.asset("assets/images/jssrc_img_user_code.png",
                            width: ScreenUtil().setWidth(42),
                            height: ScreenUtil().setHeight(42))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Image.asset(
                      "assets/images/src_pages_delivery_img_primebg.png",
                      height: ScreenUtil().setHeight(120),
                      width: ScreenUtil().width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: Image.asset(
                      "assets/images/dash_locact_bg.png",
                      height: ScreenUtil().setHeight(400),
                      width: ScreenUtil().width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 20, right: 30),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/wow_logo_red.png",
                          width: ScreenUtil().setWidth(180),
                          height: ScreenUtil().setHeight(60),
                        ),
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "90天最高劲省3266元",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(24)),
                                ),
                                Padding(padding: EdgeInsets.only(right: 20)),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                        alignment: AlignmentDirectional.center,
                                        width: ScreenUtil().setWidth(100),
                                        height: ScreenUtil().setHeight(40),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/src_pages_redcoffee_img_primebg2.png",
                                                ),
                                                fit: BoxFit.fill)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Text(
                                                "立即开通",
                                                style: TextStyle(
                                                    color: Color(0xFF4d422a),
                                                    fontSize: ScreenUtil().setSp(14)),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/jssrc_page_setting_img_arrow_right.png",
                                              width: ScreenUtil().setWidth(6),
                                              height: ScreenUtil().setHeight(11),
                                            ),
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/jssrc_img_user_default_header.png",
                          width: ScreenUtil().setWidth(120),
                          height: ScreenUtil().setHeight(120),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 95),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "肯德基会员",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(38),
                              color: Color(0xFF565656)),
                        ),
                        Image.asset(
                          "assets/images/jssrc_page_setting_img_arrow_right.png",
                          width: ScreenUtil().setWidth(44),
                          height: ScreenUtil().setHeight(24),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "我的V金",
                                style: TextStyle(
                                    color: Color(0xFF8b8b8b),
                                    fontSize: ScreenUtil().setSp(32)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("18",
                                      style: TextStyle(
                                          color: Color(0xFF474747),
                                          fontSize: ScreenUtil().setSp(48),
                                          fontWeight: FontWeight.bold)),
                                  Image.asset(
                                    "assets/images/jssrc_img_icon_v_small.png",
                                    width: ScreenUtil().setWidth(46),
                                    height: ScreenUtil().setHeight(46),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "我的卡包",
                                style: TextStyle(
                                    color: Color(0xFF8b8b8b),
                                    fontSize: ScreenUtil().setSp(32)),
                              ),
                              Text("18张",
                                  style: TextStyle(
                                      color: Color(0xFF474747),
                                      fontSize: ScreenUtil().setSp(48),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "我的V金",
                                style: TextStyle(
                                    color: Color(0xFF8b8b8b),
                                    fontSize: ScreenUtil().setSp(32)),
                              ),
                              Text("0.00元",
                                  style: TextStyle(
                                      color: Color(0xFF474747),
                                      fontSize: ScreenUtil().setSp(48),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }
}
class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.leftIcon,
    this.rightIcon,
    this.title,
    this.rightDescription,
  });

  final Widget leftIcon;
  final Widget rightIcon;
  final String title;
  final String rightDescription;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 10)),
            leftIcon,
            Padding(padding: EdgeInsets.only(left: 8)),
            Text(
              title,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28), color: Color(0xFF333333)),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              rightDescription,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28), color: Color(0xFFc5c5c5)),
            ),
            Padding(padding: EdgeInsets.only(right: 8)),
            rightIcon
          ],
        )
      ],
    );
  }
}