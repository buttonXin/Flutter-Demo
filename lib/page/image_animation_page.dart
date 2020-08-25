import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/frame_animation.dart';

class ImageAnimationPage extends StatefulWidget {
  @override
  _ImageAnimationPageState createState() => _ImageAnimationPageState();
}

class _ImageAnimationPageState extends State<ImageAnimationPage> {

  List<String> _list = [
    'images/anim/1.png',
    'images/anim/2.png',
    'images/anim/3.png',
    'images/anim/4.png',
  ];
  Map<int,Image> _map = {
       1: Image.asset('images/anim/1.png'),
       2: Image.asset('images/anim/2.png'),
       3: Image.asset('images/anim/3.png'),
       4: Image.asset('images/anim/4.png'),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('data'),
            Image.asset('images/anim/1.png'),
            Image.asset('images/anim/2.png'),
            Image.asset('images/anim/3.png'),
            Image.asset('images/anim/4.png'),
            FrameImageAnimation(_list,height: 40,),
            Text('data'),
          ],
        ));
  }
}
