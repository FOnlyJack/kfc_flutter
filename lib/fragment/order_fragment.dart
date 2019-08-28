import 'package:flutter/material.dart';

/**
 * 首页 订单
 */
class OrderFragment extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(
        child: Text("订单"),
      ),
    ));
  }
}
