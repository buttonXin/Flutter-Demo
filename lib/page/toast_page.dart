import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/stagger.dart';
import 'package:flutter_github_demo/widget/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ToastPage extends StatefulWidget {
  @override
  _ToastPageState createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> with TickerProviderStateMixin  {
  AnimationController _controller;

  @override
  void initState() {

    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );

  }
  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {

    // DefaultAssetBundle.of(context).loadString("images/data/lgu.json").then((value){
    //
    //   List<Map<String,dynamic>> map = json.decode(value);
    //   print('lao_gao-->_ToastPageState_build_$map    ${map[0]}');
    // });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 100,),

            ElevatedButton(
              onPressed: () async {

                showDialog(context: context, builder: (_){
                  return SimpleDialog(title: Text('title'),children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('close'),
                    ),
                  ],);
                });
              },
              child: Text('出现dialog'),
            ),


            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Toast.show(message: 'sdasdasqwrfadfasdfsa');

                  _playAnimation();


                },
                child: Text('点击开始动画'),
              ),
            ),
            StaggerAnimation(controller: _controller,),
          ],

        ),
      ),
    );
  }
}

