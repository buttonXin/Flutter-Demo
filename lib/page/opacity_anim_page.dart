import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/anim/my_slide_transition.dart';

class MyOpacityPage extends StatefulWidget {
  final String? title;

  MyOpacityPage({Key? key, this.title}) : super(key: key);

  @override
  _MyOpacityPageState createState() => _MyOpacityPageState();
}

class _MyOpacityPageState extends State<MyOpacityPage>
    with SingleTickerProviderStateMixin {
  bool _visible = true;

  int _count = 0;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(seconds: 3000), vsync: this);
    //图片宽高从0变到1
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('lao_gao___MyOpacityPageState_build_${animation.value}');
    print('lao_gao___MyOpacityPageState_build_${controller.value}');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),

          // RaisedButton(
          //   child: const Text(
          //     '+1',
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       _count += 1;
          //     });
          //   },
          // ),
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 500),
          //   transitionBuilder: (Widget child, Animation<double> animation) {
          //     //执行缩放动画
          //     final Tween<Offset> tween = Tween<Offset>(
          //         begin: const Offset(1, 0), end: const Offset(0, 0));
          //     return MySlideTransition(
          //       position: tween.animate(animation),
          //       child: child,
          //     );
          //   },
          //   child: Text(
          //     '$_count',
          //     //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
          //     key: ValueKey<int>(_count),
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ),

          Container(
            alignment: Alignment.center,
              width: double.infinity,
              child: Text('555555',style: TextStyle(fontSize: 50),)),

          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Text(
              "第二个子\nwidget",
              style:
                  TextStyle(backgroundColor: Colors.blueAccent, fontSize: 30),
            ),
            //用于控制显示哪个widget
            crossFadeState:
                _visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 500),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call setState. This tells Flutter to rebuild the
          // UI with the changes.
          setState(() {
            _visible = !_visible;
            if (_visible) {
              controller.forward();
            } else {
              controller.reverse();
            }
          });
        },
        tooltip: 'Toggle Opacity',
        child: const Icon(Icons.flip),
      ),
    );
  }
}
