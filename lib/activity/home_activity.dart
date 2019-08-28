import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kfc_flutter/fragment/home_fragment.dart';
import 'package:kfc_flutter/fragment/mall_fragment.dart';
import 'package:kfc_flutter/fragment/my_fragment.dart';
import 'package:kfc_flutter/fragment/order_fragment.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  final pageController = PageController(initialPage: 0);
  final List<Widget> tabs = [
    HomeFragment(),
    MallFragment(),
    OrderFragment(),
    MyFragment()
  ];
  final kfc_tab_n = [
    "assets/images/kfc_tab_tab_1_n.png",
    "assets/images/kfc_tab_tab_2_n.png",
    "assets/images/kfc_tab_tab_3_n.png",
    "assets/images/kfc_tab_tab_4_n.png"
  ];
  final kfc_tab_p = [
    "assets/images/kfc_tab_tab_1_p.png",
    "assets/images/kfc_tab_tab_2_p.png",
    "assets/images/kfc_tab_tab_3_p.png",
    "assets/images/kfc_tab_tab_4_p.png"
  ];
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: PageView(
          controller: pageController,
          children: tabs,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            _index = index;
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (i) {
                return IconButton(
                    iconSize: 48,
                    icon:
                    Image.asset(_index == i ? kfc_tab_p[i] : kfc_tab_n[i]),
                    onPressed: () {
                      setState(() {
                        _index = i;
                        pageController.jumpToPage(i);
                      });
                    });
              })),
        ),
      ),
    );
  }
}
