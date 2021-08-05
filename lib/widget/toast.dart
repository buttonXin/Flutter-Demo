import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github_demo/main.dart';

class Toast {
  static void show({@required String message}) {
    // 这里的context必须是MaterialApp下面的widget的context，否则会报错
    final BuildContext context = MyPubspecPage.navigatorState.currentContext;
    //创建一个OverlayEntry对象
    final OverlayEntry overlayEntry =
        OverlayEntry(builder: (BuildContext context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(message),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    print('lao_gao-->Toast_show_${overlayEntry == null}');
    // Future<void>.delayed(Duration.zero,(){
    //   Overlay.of(context).insert(overlayEntry);
    // });

    Builder(builder: (BuildContext context) {});
    Timer.run(() {
      Overlay.of(context).insert(overlayEntry);
    });

    //两秒后，移除Toast
    Future.delayed(Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }
}
