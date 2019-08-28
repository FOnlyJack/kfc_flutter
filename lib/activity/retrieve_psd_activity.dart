import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kfc_flutter/activity/retrieve_psd_activity_next.dart';

class RetrievePsdActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<RetrievePsdActivity> {
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
                "找回密码",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                hintText: "请输入手机号",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                icon: Image.asset(
                                  "assets/images/icon_phone.png",
                                  width: ScreenUtil().setWidth(70),
                                  height: ScreenUtil().setHeight(48),
                                )),
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/kids_cutline.png",
                        color: Colors.black,
                        height: ScreenUtil().setHeight(60),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text("发送验证码"),
                      )
                    ],
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
                                hintText: "请输入短信验证码",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                            '下一步',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RetrievePsdNextActivity()),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
