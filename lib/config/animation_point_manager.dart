import 'package:flutter/material.dart';
import 'package:kfc_flutter/config/parabolic_animation_widget.dart';
import 'package:kfc_flutter/config/popup_animation_widget.dart';


class AnimationPointManager {
  List<AnimatedWidget> list = [];

  Future<void> addParabolicAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required GlobalKey endKey,
    @required Duration duration,
    @required AnimationStatusListener statusListener,
    Color color = Colors.red,
    double size = 20,
    Offset startAdjustOffset = Offset.zero,
    Offset endAdjustOffset = Offset.zero,
  }) async {
    AnimationController controller = createController(vsync, duration);
    Animation animation = createAnimation(controller);

    AnimatedWidget animatedWidget = ParabolicAnimationWidget(
      animation: animation,
      stackKey: stackKey,
      startKey: startKey,
      endKey: endKey,
      size: size,
      color: color,
      startAdjustOffset: startAdjustOffset,
      endAdjustOffset: endAdjustOffset,
    );
    list.add(animatedWidget);
    statusListener(AnimationStatus.dismissed);

    try {
      await controller.forward().orCancel;
    } on TickerCanceled {
      print("Ticker Canceled");
    }

    list.remove(animatedWidget);
    controller.dispose();
    statusListener(AnimationStatus.completed);
  }

  Future<void> addPopupAniamtion({
    @required TickerProvider vsync,
    @required GlobalKey stackKey,
    @required GlobalKey startKey,
    @required Widget child,
    Duration duration,
    Offset popupOffset = Offset.zero,
    AnimationStatusListener statusListener,
  }) async {
    AnimationController controller = createController(vsync, duration);

    AnimatedWidget animatedWidget = PopupAnimationWidget(
      animation: controller.view,
      stackKey: stackKey,
      startKey: startKey,
      child: child,
      popupOffset: popupOffset,
    );
    list.add(animatedWidget);
    statusListener(AnimationStatus.dismissed);

    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {
      print("Ticker Canceled");
    }

    list.remove(animatedWidget);
    controller.dispose();

    statusListener(AnimationStatus.completed);
  }

  static AnimationController createController(
      TickerProvider vsync, Duration duration) {
    AnimationController ani = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        duration: duration ?? Duration(milliseconds: 800),
        vsync: vsync);
    return ani;
  }

  static CurvedAnimation createAnimation(controller) {
    return CurvedAnimation(parent: controller, curve: Curves.linear);
  }
}

/*
* import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'animation_point_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int count = 0;

  AnimationPointManager _animationPointManager = AnimationPointManager();

  GlobalKey stackKey = GlobalKey();
  GlobalKey endKey = GlobalKey();

  itemOnTap(GlobalKey startKey) {
    print("start key " + startKey.toString());
    print("stack key " + stackKey.toString());
    print("end key " + endKey.toString());

    _animationPointManager.addParabolicAniamtion(
      vsync: this,
      stackKey: stackKey,
      startKey: startKey,
      endKey: endKey,
      color: Colors.green,
      statusListener: (AnimationStatus status) {
        setState(() {});
        if (status == AnimationStatus.completed) {
          buyOnTap();
        }
      },
      duration: Duration(milliseconds: 700),
    );
  }

  buyOnTap() {
    _animationPointManager.addPopupAniamtion(
      vsync: this,
      stackKey: stackKey,
      startKey: endKey,
      child: Container(
        width: 100,
        color: Colors.green,
        padding: EdgeInsets.all(25),
        child: Icon(Icons.home, size: 50, color: Colors.white),
      ),
      popupOffset: Offset(0, -50),
      duration: Duration(milliseconds: 800),
      statusListener: (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            count += 1;
          });
        } else {
          setState(() {});
        }
      },
    );
  }

  ShopListView _shopListView;
  BuyCartView _buyCartView;

  @override
  Widget build(BuildContext context) {
    _shopListView ??= ShopListView(onTap: itemOnTap);
    _buyCartView = BuyCartView(
      count,
      endKey: endKey,
      onTap: buyOnTap,
    );

    List<Widget> childrens = [_shopListView, _buyCartView];

    //step 4
    print("pointers: " + _animationPointManager.list.length.toString());
    childrens += _animationPointManager.list;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(child: Stack(key: stackKey, children: childrens)),
    );
  }
}

class BuyCartView extends StatelessWidget {
  final int count;
  final GlobalKey endKey;
  final Function onTap;

  BuyCartView(this.count, {this.endKey, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 20,
      right: 20,
      child: Container(
        color: Colors.grey,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                key: endKey,
                alignment: Alignment.center,
                width: 120,
                color: Colors.redAccent,
                child: Text("购物车" + count.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopListView extends StatelessWidget {
  final Function onTap;
  ShopListView({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      height: 500,
      child: Container(
        child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                GlobalKey key = GlobalKey();
                return Container(
                  color: index % 2 == 0 ? Colors.black26 : Colors.black12,
                  alignment: Alignment.centerRight,
                  width: 50,
                  child: GestureDetector(
                    onTap: () => onTap(key),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      height: 60,
                      alignment: Alignment.center,
                      key: key,
                      width: 120,
                      color: Colors.redAccent,
                      child: Text("加入购物车 $index"),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
* */