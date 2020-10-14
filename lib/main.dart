import 'dart:async';

import 'package:cache_image/cache_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'page/authority_page.dart';
import 'page/image_animation_page.dart';
import 'page/popup_window_page.dart';
import 'page/slider_page.dart';
import 'page/toast_page.dart';
import 'page/video/video2_page.dart';
import 'page/video/video3_page.dart';
import 'page/video/video4_page.dart';
import 'page/video/video5_page.dart';
import 'util/http_download_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPubspecPage(),
    );
  }
}

class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('images/splash.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void initState() {
    // 启动的时候将屏幕设置成全屏模式
//    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    Timer(
        Duration(milliseconds: 300),
        () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              print('lao_gao-->_MySplashPageState_initState_}');
              return MyPubspecPage();
            })));
  }

  @override
  void dispose() {
    // 关闭的时候将屏幕设置成原来的状态
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}

/// 使用的第三方在这里进行测试
class MyPubspecPage extends StatefulWidget {
  @override
  _MyPubspecPageState createState() => _MyPubspecPageState();
}

class _MyPubspecPageState extends State<MyPubspecPage>
    with WidgetsBindingObserver {
  StreamController<String> _controller = new StreamController.broadcast();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('lao_gao--> build');
    final pluginSdkMap = <String, Function>{
      "缓存图片框架": (context) => CacheNetworkImage(),
      "PopupWindow": (context) => PopupWindowPage(),
      "viewPager": (context) => MyViewPager(),
      "SliderPage滑动条界面": (context) => SliderPage(),
      "json解析page": (context) => DataJsonPage(),
      "dio下载文件": (context) => DownloadFilePage(),
      "帧动画页面": (context) => ImageAnimationPage(),
      "权限申请的页面": (context) => AuthorityPage(),
      "开源video2Chewie页面": (context) => ChewieDemo(),
      "开源video3页面": (context) => Video4Page(
            title: '测试4video',
          ),
      "开源video5页面": (context) => Video5Page(
            title: '测试5video',
          ),
      "原生的video页面": (context) => VideoPage(),
      "toast页面": (context) => ToastPage(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('测试第三方框架'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
          itemCount: pluginSdkMap.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            var title = pluginSdkMap.keys.toList()[index];
            return ListTile(
              title: Text(title),
              onTap: () {
                if (pluginSdkMap[title] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: pluginSdkMap[title]),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('lao_gao--> resumed}');
        break;
      case AppLifecycleState.paused:
        print('lao_gao--> paused}');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    print('lao_gao--> initState');
    WidgetsBinding.instance.addObserver(this);

    // 这个方法可以在init的时候 去执行 与context相关的UI
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      // fetch data
////      Navigator.of(context).pushNamed('/');
//      Toast.show(context: context, message: '444444444fffff');
//    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('lao_gao--> didChangeDependencies}');

    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    print('lao_gao--> setState }');
    super.setState(fn);
  }

  @override
  void didUpdateWidget(MyPubspecPage oldWidget) {
    print('lao_gao--> didUpdateWidget}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('lao_gao--> deactivate{}');
    super.deactivate();
  }

  @override
  void dispose() {
    print('lao_gao--> dispose}');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

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
  StreamController<DownloadStatus> controller;

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
    return StreamBuilder<DownloadStatus>(
        stream: controller?.stream,
        builder: (context, snapshot) {
          Widget child = getWidget(snapshot);
          return RaisedButton(
            onPressed: () {
              controller = HttpDownloadFile()
                  .startDownloadFile(widget.url, "apkpure${widget.name}.apk");
              print('lao_gao-->sss ${controller}');
              setState(() {});
            },
            child: child,
          );
        });
  }

  Widget getWidget(AsyncSnapshot<DownloadStatus> snapshot) {
    print('lao_gao-->222 ${snapshot}');
    if (snapshot.data == null || snapshot.data.dddd == Dddd.init) {
      return Row(
        children: [
          Text("点击下载${widget.name}"),
        ],
      );
    } else if (snapshot.data.dddd == Dddd.complete) {
      return Row(
        children: [
          Text("下载完成${widget.name}"),
        ],
      );
    } else if (snapshot.data.dddd == Dddd.cancel) {
      return Row(
        children: [
          Text("已取消下载${widget.name}"),
        ],
      );
    } else if (snapshot.data.dddd == Dddd.loading) {
      return Row(
        children: [
          Text("下载中${widget.name}"),
          CircularProgressIndicator(
            value: snapshot.data.progress,
          ),
        ],
      );
    }
    return Center();
  }
}

class CacheNetworkImage extends StatefulWidget {
  @override
  _CacheNetworkImageState createState() => _CacheNetworkImageState();
}

class _CacheNetworkImageState extends State<CacheNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Expanded(child: Image.asset("images/1.webp")),
            Expanded(
                child: Image(
                    fit: BoxFit.cover, image: CacheImage("images/9.png"))),
            Expanded(
              child: CachedNetworkImage(
                imageUrl:
                    "http://pic.616pic.com/bg_w1180/00/10/43/CnJ5y84QFt.jpg",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyViewPager extends StatefulWidget {
  @override
  _MyViewPagerState createState() => _MyViewPagerState();
}

class _MyViewPagerState extends State<MyViewPager> {
  // 当前图片的位置
  int _current = 0;
  int length = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PreloadPageView.builder(
                itemCount: 9,
                physics: AlwaysScrollableScrollPhysics(),
                preloadPagesCount: 5,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                  print('page changed. current: $index');
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    'images/tutorial/${index + 1}.webp',
                    fit: BoxFit.fitHeight,
                  );
                }),
          ),

          // 底部指示器
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(length, (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.white : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataJsonPage extends StatefulWidget {
  @override
  _DataJsonPageState createState() => _DataJsonPageState();
}

class _DataJsonPageState extends State<DataJsonPage> {
  @override
  Widget build(BuildContext context) {
//    var recommendList = RecommendApps.recommendAppListFromJson(Constant.dataJson["data"]);

//    print("laogao--> ${recommendList.length} \n  ${recommendList.toString()}");

    return Container(
      child: Text("dsadas"),
    );
  }
}
