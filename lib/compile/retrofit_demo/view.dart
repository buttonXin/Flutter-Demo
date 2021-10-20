import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RetrofitDemoPage extends StatelessWidget {
  final RetrofitDemoLogic logic = Get.put(RetrofitDemoLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              logic.getInitData();
            },
            child: const Text('测试retrofit的base'),
          ),
          ElevatedButton(
            onPressed: () {
              logic.getVersion();
            },
            child: const Text('测试nebula的新接口'),
          ),
          GestureDetector(
              onLongPress: () {
                Clipboard.setData(const ClipboardData(text: '复制到剪切板'));
                Fluttertoast.showToast(msg: '复制到剪切板');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('复制到剪切板'),
              )),
          SelectableText(
            'oldhighxojohohohxxxx',
            onTap: () {
              Fluttertoast.showToast(msg: 'oldhighxojohohohxxxx');
            },
          ),
        ],
      ),
    );
  }
}
