import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/anim_button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

/**
 * ScaleTransition 实现 缩放动画
 */
class ScaleTransitionPage extends StatefulWidget {
  @override
  _ScaleTransitionPageState createState() => _ScaleTransitionPageState();
}

//是我这里使用到的一个基类
class _ScaleTransitionPageState extends State<ScaleTransitionPage>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController controller;
  late Animation<double> animation;

  final Image _normalButton = Image.asset('images/anim/enter_normal.png');
  final Image _pressedButton = Image.asset('images/anim/enter_pressed.png');
  Image _enterButton = Image.asset('images/anim/enter_button.png');
  Image? _selectorImage;
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
    precacheImage(_normalButton.image, context);
    precacheImage(_pressedButton.image, context);
    precacheImage(_enterButton.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 200,
          ),
          Expanded(
            child: AnimButtonView(onTap: (){
              Fluttertoast.showToast(msg: '跳转到space111');

            },),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
