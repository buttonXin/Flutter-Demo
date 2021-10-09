import 'package:flutter/material.dart';

class ButtonAnimationPage extends StatefulWidget {
  @override
  _ButtonAnimationPageState createState() => _ButtonAnimationPageState();
}

class _ButtonAnimationPageState extends State<ButtonAnimationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();

  final Widget _normalButton = Image.asset('images/anim/enter_normal.png');
  final Widget _pressedButton = Image.asset('images/anim/enter_normal.png');
  Widget? _enterButton;

  late AnimationController controller;
  late Animation<double> animation;

  double _buttonHeight = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(seconds: 3000), vsync: this);
    //图片宽高从0变到300
    animation = Tween<double>(begin: 1, end: 0.5).animate(controller);
    animation.addStatusListener((AnimationStatus status) {
      print('lao_gao-->_ButtonAnimationPageState_initState_${status}');
      // if (status == AnimationStatus.completed) {
      //   //动画执行结束时反向执行动画
      //   // controller.reverse();
      // } else if (status == AnimationStatus.dismissed) {
      //   //动画恢复到初始状态时执行动画（正向）
      //   controller.forward();
      // }
    });

    //启动动画（正向）
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print('lao_gao-->_ButtonAnimationPageState_build_${animation.value}');
    _enterButton = Image.asset(
      'images/anim/enter_button.png',
      key: _buttonKey,
      // width: MediaQuery.of(context).size.width / 2.5 ,
      // height: MediaQuery.of(context).size.width / 2.5 ,
    );
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Expanded(
            child:  Stack(
                alignment: Alignment.center,
                children: [
                  // Positioned(
                  //     top: 30,
                  //     bottom: 0,
                  //     left: 0,
                  //     right: 0,
                  //     child: _pressedButton),
                  // Positioned(child: _enterButton)
                  GestureDetector(
                    onTap: () {
                      print('lao_gao-->_ButtonAnimationPageState_build_}');
                      if (!controller.isCompleted) {
                        controller.forward();
                      }
                    },
                    child: ScaleTransition(
                        scale: animation,
                        //设置动画的缩放中心
                        alignment: Alignment.center,
                        child: _enterButton),
                  )
                ],
              ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback(_getContainerHeight);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ButtonAnimationPage oldWidget) {
    WidgetsBinding.instance!.addPostFrameCallback(_getContainerHeight);
    super.didUpdateWidget(oldWidget);
  }

   _getContainerHeight(_) {
    _buttonHeight = _buttonKey.currentContext!.size!.height;
  }
}

class ButtonAnimationWidget extends StatelessWidget {
  ButtonAnimationWidget({this.child, this.animation});

  final Widget? child;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation!,
          builder: (BuildContext context, Widget? child) {
            return Container(
                height: animation!.value, width: animation!.value, child: child);
          },
          child: child),
    );
  }
}
