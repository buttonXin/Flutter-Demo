import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/cricle_anim_view.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with TickerProviderStateMixin {
  double _value = 0;
  int _dollars = 20;

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
            onChanged: (newValue) {
              print('onChanged:$newValue');
              setState(() {
                _value = newValue;
              });
            },
            onChangeStart: (startValue) {
              print('onChangeStart:$startValue');
            },
            onChangeEnd: (endValue) {
              print('onChangeEnd:$endValue');
            },
            label: '$_value dollars',
            divisions: 5,
            semanticFormatterCallback: (newValue) {
              return '${newValue.round()} dollars';
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

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

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
}
