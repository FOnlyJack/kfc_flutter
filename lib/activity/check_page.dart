import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

/**
 * 会员码
 */
class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Container(
        width: ScreenUtil().width,
        height: ScreenUtil().height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/coverbg.png"), fit: BoxFit.fill),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 13, left: 11),
                    child: Image.asset(
                      "assets/images/icon_closewhite.png",
                      width: ScreenUtil().setWidth(60),
                      height: ScreenUtil().setHeight(64),
                    ),
                  )
                ],
              ),
              Expanded(child: Text("")),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: EdgeInsets.only(left: 10, right: 10),
                width: ScreenUtil().width,
                height: ScreenUtil().setHeight(1000),
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/graybox2.jpg",
                          height: ScreenUtil().setHeight(100),
                          width: ScreenUtil().width,
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/images/vipcode_wow.png",
                          width: ScreenUtil().setWidth(120),
                          height: ScreenUtil().setHeight(60),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      width: ScreenUtil().setWidth(768),
                      height: ScreenUtil().setHeight(192),
                      child: BarCodeImage(
                        data: "1234ABCD",
                        codeType: BarCodeType.Code93,
                        hasText: false,
                        onError: (error) {
                          print('error = $error');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        "3737373737373737373",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            color: Color(0xff404040)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      width: ScreenUtil().setWidth(390),
                      height: ScreenUtil().setHeight(390),
                      child: QrImage(
                        data: "1234567890",
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/icon_info2.png",
                            width: ScreenUtil().setWidth(36),
                            height: ScreenUtil().setHeight(36),
                          ),
                          Text(
                            "本会员码定时更新，请勿截屏，以免影响正常使用。",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(36),
                                color: Color(0xff404040)),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(child: Text("")),
              Divider(
                height: 1,
                color: Color(0xFFdddddd),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/vipcode_zfb.png",
                          width: ScreenUtil().setWidth(166),
                          height: ScreenUtil().setHeight(166),
                        ),
                        Text(
                          "支付宝",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/vipcode_wx.png",
                          width: ScreenUtil().setWidth(166),
                          height: ScreenUtil().setHeight(166),
                        ),
                        Text(
                          "微信支付",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/vipcode_vpay.png",
                          width: ScreenUtil().setWidth(166),
                          height: ScreenUtil().setHeight(166),
                        ),
                        Text(
                          "神钱包",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/vipcode_cardbag.png",
                          width: ScreenUtil().setWidth(166),
                          height: ScreenUtil().setHeight(166),
                        ),
                        Text(
                          "我的卡包",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
