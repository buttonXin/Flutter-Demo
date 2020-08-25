import 'package:flutter/material.dart';

class DownloadStateView {
  static void show(
      {@required BuildContext context, @required Stream<String> stream}) {
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return StreamBuilder<String>(
          stream: stream,
          builder: (context, snapshot) {
            String text = 'init';
            switch (snapshot.data) {
              case 'add':
                text = snapshot.data;
                break;
              case 'stop':
                text = snapshot.data;
                break;
              case 'error':
                text = snapshot.data;
                break;
              case 'complete':
                text = snapshot.data;
                break;
              default:
                break;
            }

            return new Positioned(
                bottom: 0,
                child: new Material(
                  color: Colors.black,
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: new Center(
                      child: new Card(
                        child: new Padding(
                          padding: EdgeInsets.all(8),
                          child: new Text(text),
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ));
          });
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);
    //两秒后，移除Toast

    stream.listen((event) {
      if ('complete' == event) {
        new Future.delayed(Duration(seconds: 2)).then((value) {
          overlayEntry.remove();
        });
      }
    });
  }
}

/// 从native层得到的数据
class CheckResultData {
  bool isUpdate;

  String pid;
  String packageName;
  String updateVersionName;
  int updateVersionCode;

  /// 收到download的action事件
  String action;

  CheckResultData(
      {this.isUpdate,
      @required this.pid,
      this.packageName,
      this.updateVersionName,
      this.action,
      this.updateVersionCode = 0});

  CheckResultData.fromJson(Map<dynamic, dynamic> json)
      : isUpdate = json['IS_UPDATE'],
        pid = json['PID'],
        updateVersionName = json['UPDATE_VERSION_NAME'],
        // 默认值是0，表示本地没有安装当前apk/或者云端返回错误的数据
        updateVersionCode = json['UPDATE_VERSION_CODE'] ?? 0,
        action = json['download_action'],
        packageName = json['PACKAGENAME'];

  @override
  String toString() {
    return 'CheckResultData{isUpdate: $isUpdate, pid: $pid, packageName: $packageName,'
        ' updateVersionName: $updateVersionName, updateVersionCode: $updateVersionCode, action: $action}';
  }
}

/// check后的回调
typedef CheckCallback = void Function(CheckResultData checkResultData);
