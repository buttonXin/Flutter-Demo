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
            child: const Text('测试retrofit的base'),
            onPressed: () {
              logic.getInitData();
            },
          ),
          ElevatedButton(
            child: const Text('获取domain集合'),
            onPressed: () {
              logic.getDomainList();
            },
          ),
          ElevatedButton(
            child: const Text('获取nebula黑名单'),
            onPressed: () {
              logic.getNebulaData();
            },
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('复制到剪切板'),
            ),
            onLongPress: () {
              Clipboard.setData(const ClipboardData(text: '复制到剪切板'));
              Fluttertoast.showToast(msg: '复制到剪切板');
            },
          ),
          SelectableText(
            'oldhighxojohohohxxxx',
            onTap: () {
              Fluttertoast.showToast(msg: 'oldhighxojohohohxxxx');
            },
          ),
          Row(
            children: [
              Expanded(child: Text('data')),
              Expanded(child: Text('data')),
            ],
          )
        ],
      ),
    );
  }
}

class LocalPackageInfo {
  LocalPackageInfo(
      {this.appName, this.packageName, this.versionName, this.versionCode = 0});

  LocalPackageInfo.fromJson(Map<dynamic, dynamic> json)
      : appName = json['appName'],
        packageName = json['packageName'],
        versionName = json['version'],
        // 默认值是0
        versionCode = double.tryParse(json['buildNumber']) ?? 0;

  String? appName;
  String? packageName;
  String? versionName;
  double versionCode;

  @override
  String toString() {
    return 'LocalPackageInfo{appName: $appName, packageName: $packageName, versionName: $versionName, versionCode: $versionCode}';
  }
}
