import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ImagesAnimation extends StatefulWidget {
  final double w;
  final double h;
  final ImagesAnimationEntry entry;
  final int durationSeconds;

  ImagesAnimation({
    Key key,
    this.w,
    this.h,
    this.entry,
    this.durationSeconds: 1,
  }) : super(key: key);

  @override
  ImagesAnimationState createState() {
    return ImagesAnimationState();
  }

  Widget _buildWrapper({
    @required BuildContext context,
    @required Widget child,
  }) {
    return child;
  }
}

class ImagesAnimationState extends State<ImagesAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animatable<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.durationSeconds))
      ..repeat();
    _animation = StepTween(
        begin: widget.entry.lowIndex, end: widget.entry.highIndex + 1);
  }

  @override
  void didUpdateWidget(ImagesAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_controller.isAnimating) {
      _controller.repeat();
    } else if (_controller.isAnimating) _controller.stop();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, String frame) {
    return widget._buildWrapper(
      context: context,
      child: Image.asset(
        sprintf(widget.entry.basePath, [frame]),
        gaplessPlayback: true,
        width: widget.w,
        height: widget.h,
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
            context, _animation.evaluate(_controller).toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimation();
  }
}

class ImagesAnimationEntry {
  int lowIndex = 0;
  int highIndex = 0;
  String basePath;

  ImagesAnimationEntry(this.lowIndex, this.highIndex, this.basePath);
}
