import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_github_demo/model/app_update_info.dart';
import 'package:flutter_github_demo/util/L.dart';
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
          ),ElevatedButton(
            onPressed: () {
              final LocalPackageInfo  info = LocalPackageInfo();
              L.e('RetrofitDemoPage.build_000  ${info.versionCode}');
              L.e('RetrofitDemoPage.build_2222}');
            },
            child: const Text('测试空内容'),
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
