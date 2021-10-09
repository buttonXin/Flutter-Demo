import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github_demo/util/http_download_file.dart';
// import 'package:install_plugin/install_plugin.dart';

class DownloadFilePage extends StatefulWidget {
  @override
  _DownloadFilePageState createState() => _DownloadFilePageState();
}

class _DownloadFilePageState extends State<DownloadFilePage> {
  final apkUrl = 'https://d-37.winudf.com/custom/com.apkpure.aegon-3171001.apk';
  final apkUrlWangYi30 =
      'https://alissl.ucdl.pp.uc.cn/fs08/2020/07/08/10/2_c49c05d635c8c6ef197129791f81621e.apk';
  final qqUrl88 =
      'https://alissl.ucdl.pp.uc.cn/fs08/2020/06/17/5/110_38b1fd4b62bc550f5968c7fb160d3b53.apk';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: ListView(
          children: [
            DownloadItem(apkUrl, '1'),
            DownloadItem(apkUrlWangYi30, '2'),
            DownloadItem(qqUrl88, '3'),
            RaisedButton(
              onPressed: () async {
                final result =
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Center(child: DownloadItem(apkUrl, '1'));
                }));
              },
              child: Text("点击跳转 与1 一致"),
            ),
            RaisedButton(
              onPressed: () {
                HttpDownloadFile().cancelDownload(apkUrl);
              },
              child: Text("取消1"),
            ),
            RaisedButton(
              onPressed: () {
                HttpDownloadFile().cancelDownload(apkUrlWangYi30);
              },
              child: Text("取消2"),
            ),
            RaisedButton(
              onPressed: () {
                HttpDownloadFile().cancelDownload(qqUrl88);
              },
              child: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Text("取消3");
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}

class DownloadItem extends StatefulWidget {
  final String url;
  final String name;

  DownloadItem(this.url, this.name);

  @override
  _DownloadItemState createState() => _DownloadItemState();
}

class _DownloadItemState extends State<DownloadItem> {
  StreamController<DownloadResult?>? controller;

  @override
  void initState() {
    controller = HttpDownloadFile().getStreamController(widget.url);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DownloadResult?>(
        stream: controller?.stream,
        builder: (context, snapshot) {
          Widget child = getWidget(snapshot);
          return RaisedButton(
            onPressed: () {
              controller = HttpDownloadFile().startDownloadFile(
                  widget.url, "asd.12.as.as.apkpure${widget.name}.apk") as StreamController<DownloadResult?>?;
              print('lao_gao-->sss ${controller}');
              setState(() {});
            },
            child: child,
          );
        });
  }

  Widget getWidget(AsyncSnapshot<DownloadResult?> snapshot) {
    print('lao_gao-->222 ${snapshot}');
    if (snapshot.data == null ||
        snapshot.data!.downloadStatus == DownloadStatus.init) {
      return Row(
        children: [
          Text("点击下载${widget.name}"),
        ],
      );
    } else if (snapshot.data!.downloadStatus == DownloadStatus.complete) {
      print('lao_gao-->_DownloadItemState_getWidget_${snapshot.data!.fileName}');
      // InstallPlugin.installApk(snapshot.data.fileName, 'com.laogao.flutter_github_demo')
      //     .then((result) {
      //   print('install apk $result');
      // }).catchError((error) {
      //   print('install apk error: $error');
      // });
      return Row(
        children: [
          Text("下载完成${widget.name}"),
        ],
      );
    } else if (snapshot.data!.downloadStatus == DownloadStatus.cancel) {
      return Row(
        children: [
          Text("已取消下载${widget.name}"),
        ],
      );
    } else if (snapshot.data!.downloadStatus == DownloadStatus.loading) {
      return Row(
        children: [
          Text("下载中${widget.name}"),
          CircularProgressIndicator(
            value: snapshot.data!.progress,
          ),
        ],
      );
    }
    return Center();
  }
}
