import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kfc_flutter/activity/login_activity.dart';
import 'package:kfc_flutter/activity/retrieve_psd_activity.dart';

class PsdLoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<PsdLoginActivity> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
                size: 40,
              ),
              onPressed: () {}),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "密码登录",
                style: TextStyle(color: Colors.red),
              ),
              Image.asset(
                "assets/images/headerbg.png",
                width: ScreenUtil().setWidth(86),
                height: ScreenUtil().setHeight(16),
              )
            ],
          ),
          elevation: 2,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginActivity()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  "验证码登录",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg_home2.png"),
                    fit: BoxFit.fill)),
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 10),
                  height: ScreenUtil().setHeight(130),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          hintText: "请输入手机号",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          icon: Image.asset(
                            "assets/images/icon_phone.png",
                            width: ScreenUtil().setWidth(70),
                            height: ScreenUtil().setHeight(48),
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  height: ScreenUtil().setHeight(130),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                hintText: "请输入登录密码",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                suffixIcon: IconButton(
                                    icon: Image.asset(
                                        "assets/images/icon_eyeclose.jpg",
                                        width: ScreenUtil().setWidth(80),
                                        height: ScreenUtil().setHeight(42)),
                                    onPressed: () {}),
                                icon: Image.asset(
                                  "assets/images/icon_pw2.png",
                                  width: ScreenUtil().setWidth(70),
                                  height: ScreenUtil().setHeight(48),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().width,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Card(
                      color: Colors.grey,
                      elevation: 5,
                      child: FlatButton(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '登录',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        onPressed: () {},
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RetrievePsdActivity()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 25, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "忘记密码",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
