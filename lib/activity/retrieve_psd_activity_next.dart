import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetrievePsdNextActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<RetrievePsdNextActivity> {
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
        body:SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image:AssetImage("assets/images/bg_home2.png"),fit: BoxFit.fill)
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  child: Text("为180****1111设置新的登录密码"),
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
                            '登录并登录',
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        onPressed: () {},
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