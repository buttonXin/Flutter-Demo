import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AnimButtonView extends StatefulWidget {
  final Function? onTap;

  // ignore: sort_constructors_first
  const AnimButtonView({Key? key, this.onTap}) : super(key: key);
  @override
  _AnimButtonViewState createState() => _AnimButtonViewState();
}

class _AnimButtonViewState extends State<AnimButtonView>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController controller;
  late Animation<double> animation;

  final Image _normalButton = Image.asset('images/anim/enter_normal.png');
  final Image _pressedButton = Image.asset('images/anim/enter_pressed.png');
  final Image _enterButton = Image.asset('images/anim/enter_button.png');
  late Image _selectorImage;
  bool _buttonUp = false;

  @override
  void initState() {
    super.initState();
    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    controller = AnimationController(
        duration: const Duration(milliseconds: 30), vsync: this);
    animation = Tween<double>(begin: 1, end: 0.9).animate(controller);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        setState(() {
          if (_buttonUp) {
            controller.reset();
            _selectorImage = _normalButton;
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
      } else if (status == AnimationStatus.forward) {
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
      }
    });

    _selectorImage = _normalButton;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 预加载图片
    precacheImage(_normalButton.image, context);
    precacheImage(_pressedButton.image, context);
    precacheImage(_enterButton.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            GestureDetector(
              child: Container(
                child: Stack(
                  children: [
                    Positioned(child: _selectorImage),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: buildRotationTransition(),
                    ),
                    const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Text(
                          'enter space',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ))
                  ],
                ),
              ),
              onTapDown: (_) {
                //正向动画开始
                setState(() {
                  _buttonUp = false;
                  _selectorImage = _pressedButton;
                });
                controller.forward();
              },
              onTapCancel: () {
                setState(() {
                  if (_buttonUp) {
                    _selectorImage = _normalButton;
                  }
                });
                controller.reset();
              },
              onTapUp: (_) {
                setState(() {
                  _buttonUp = true;
                  _selectorImage = _normalButton;
                  controller.reset();
                });
              },
              onTap: () {
                widget.onTap!();
              },
            ),
          ],
        ),
      ],
    );
  }

  //缩放
  Widget buildRotationTransition() {
    return Center(
      child: ScaleTransition(
        //设置动画的缩放中心
        alignment: Alignment.center,
        //动画控制器
        scale: animation,
        //将要执行动画的子view
        child: _enterButton,
      ),
    );
  }
}
