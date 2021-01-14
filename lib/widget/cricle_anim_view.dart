import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedUpArrow extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0);
  final Tween<double> _marginTween = Tween(begin: 0, end: 40);

  AnimatedUpArrow({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return SafeArea(
      child: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: EdgeInsets.only(bottom: _marginTween.evaluate(animation)),
            child: Icon(
              Icons.arrow_upward,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

class SpreadWidget extends StatefulWidget {
  SpreadWidget({
    this.child,
    @required this.radius,
    @required this.maxRadius,
    this.cycles,
    this.spreadColor = Colors.grey,
    this.duration = const Duration(milliseconds: 2000),
  });

  final Widget child;
  final double radius;
  final double maxRadius;
  final int cycles;
  final Color spreadColor;
  final Duration duration;

  @override
  _SpreadWidgetState createState() => _SpreadWidgetState();
}

class _SpreadWidgetState extends State<SpreadWidget>
    with TickerProviderStateMixin {
  List<Widget> children = [];
  List<AnimationController> controllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.child != null) {
      children.add(
        ClipOval(
          child: SizedBox(
            width: widget.radius,
            height: widget.radius,
            child: widget.child,
          ),
        ),
      );
    }
    start();
  }

  start() async {
    int i = 0;
    while (widget.cycles == null ? true : i < widget.cycles) {
      if (mounted) {
        setState(() {
          AnimationController _animationController;
          Animation<double> _animation;

          _animationController =
              AnimationController(vsync: this, duration: widget.duration);
          _animation = CurvedAnimation(
              parent: _animationController, curve: Curves.linear);

          _animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              children.removeAt(0);
              controllers.removeAt(0);
              _animationController.dispose();
            }
          });
          controllers.add(_animationController);
          _animationController.forward();

          widget.child != null
              ? children.insert(
                  children.length - 1,
                  AnimatedSpread(
                    animation: _animation,
                    radius: widget.radius,
                    maxRadius: widget.maxRadius,
                    color: widget.spreadColor,
                  ))
              : children.add(AnimatedSpread(
                  animation: _animation,
                  radius: widget.radius,
                  maxRadius: widget.maxRadius,
                  color: widget.spreadColor,
                ));
        });
      }
      if (widget.cycles != null) i++;
      await Future.delayed(
          Duration(milliseconds: widget.duration.inMilliseconds ~/ 3));
    }
  }

  @override
  void dispose() {
    controllers.forEach((c) {
      c.dispose();
      c = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children,
      alignment: Alignment.center,
    );
  }
}

class AnimatedSpread extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0);
  final Tween<double> _radiusTween;
  final Color color;

  AnimatedSpread(
      {Key key,
      @required Animation<double> animation,
      @required double radius,
      @required double maxRadius,
      @required this.color})
      : _radiusTween = Tween(begin: radius, end: maxRadius),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      width: _radiusTween.evaluate(animation),
      height: _radiusTween.evaluate(animation),
      child: ClipOval(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }
}

class ScaleTransitionExample extends StatefulWidget {
  @override
  _ScaleTransitionExampleState createState() => _ScaleTransitionExampleState();
}

class _ScaleTransitionExampleState extends State<ScaleTransitionExample>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _animation =
        Tween<double>(begin: 0, end: 10.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          })
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _animationController.duration= Duration(milliseconds: 10);
        _animationController.reverse();
      }
    })
    ;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_){
        _animationController.duration= const Duration(milliseconds: 300);
        _animationController.forward();
      },
      child: Container(
        margin: EdgeInsets.all(_animation.value),
        child: Image.asset(
          'images/enter_space.png',
        ),
      ),
    );
  }
}
