import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfc_flutter/bean/ChangeNotifiBean.dart';
import 'activity/home_activity.dart';
import 'package:provider/provider.dart';


void main() {
  //注册路由 ....

  runApp(MyApp());

  //状态栏沉浸
  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChangeNotifiBean>(
            builder: (_) => ChangeNotifiBean())
      ],
      child: AnnotatedRegion(
          child: MaterialApp(
            home: HomeActivity(),
          ),
          //状态栏字体颜色
          value: SystemUiOverlayStyle.dark),
    );
  }
}
