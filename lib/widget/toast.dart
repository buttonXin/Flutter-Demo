import 'dart:async';

import 'package:flutter/material.dart';

class Toast {
  factory Toast() {
    return _instance;
  }

  Toast._internal();

  static final Toast _instance = Toast._internal();

  OverlayEntry? _overlayEntry = OverlayEntry(builder: (_) {
    return Container();
  });
  bool _isShow = false;

  Timer? _timer;

  void show(BuildContext context, {required String message}) {
    // 这里的context必须是MaterialApp下面的widget的context，否则会报错
    // final BuildContext? context = MySplashPage.navigatorState.currentContext;
    _remove();

    //创建一个OverlayEntry对象
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
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
    print('lao_gao-->Toast_show_${_overlayEntry == null}');
    // Future<void>.delayed(Duration.zero,(){
    //   Overlay.of(context).insert(overlayEntry);
    // });

    Timer.run(() {
      Overlay.of(context)!.insert(_overlayEntry!);
      _isShow = true;
    });
    //两秒后，移除Toast
    _timer = Timer(const Duration(seconds: 3), () {
      _remove();
    });
  }

  void _remove() {
    if (_isShow) {
      _overlayEntry!.remove();
      _isShow = false;
      _timer?.cancel();
    }
  }
}
