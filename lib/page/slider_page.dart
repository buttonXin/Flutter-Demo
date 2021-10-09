import 'package:flutter/material.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_github_demo/widget/cricle_anim_view.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with TickerProviderStateMixin {
  double _value = 35;
  int _dollars = 20;

  // GifController _gifController;

  @override
  void initState() {
    super.initState();

    // _gifController = GifController(vsync: this);
    //
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _gifController.repeat(min:0,max:29,period:const Duration(milliseconds: 2000));
    //   // jumpTo thrid frame(index from 0)
    //   // _gifController.value = 0;
    // });



    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        print('lao_gao-->_SliderPageState_initState_11}');
        _animationController.forward();
      } else if (status == AnimationStatus.completed) {
        print('lao_gao-->_SliderPageState_initState_222}');
        Future.delayed(Duration(milliseconds: 500), () {
          _animationController.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Slider(
            value: _value,
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: (double newValue) {
              setState(() {
                _value = newValue;
              });
            },
            onChangeEnd: (double endValue) {
              print('onChangeEnd:${endValue.round()}');
              //这里进行保存
            },
            label: '${_value.round()}%',
            semanticFormatterCallback: (double newValue) {
              return '${newValue.round()} ';
            },
          ),
          Slider(
              value: _dollars.toDouble(),
              min: 20.0,
              max: 330.0,
              label: '$_dollars dollars',
              onChanged: (double newValue) {
                setState(() {
                  _dollars = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              }),
          GestureDetector(
              onTap: () {
                _animationController.forward();
              },
              onDoubleTap: () {
                _animationController.stop();
              },
              child: AnimatedUpArrow(animation: _animation)),
          Text('data'),
          // GifImage(
          //   controller: _gifController,
          //   image: AssetImage("images/animate.gif"),
          // ),
          Spacer(),
          Container(
            width: 200,
            height: 200,
            child: Center(
                child: SpreadWidget(
              radius: 100,
              maxRadius: 120,
              spreadColor: Colors.red,
              child: ScaleTransitionExample(),
            )),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  late AnimationController _animationController;
  late Animation<double> _animation;
}
