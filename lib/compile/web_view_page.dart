import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 浏览器的page
class WebViewPage extends StatefulWidget {
  WebViewPage({Key key, this.path, this.initUrl = 'https://www.nreal.ai/h5/nebula/privacy-policy/?lang=en', this.title = 'demo'})
      : super(key: key);

  /// path 和initUrl 最少传一个。
  /// 本地地址
  final String path;

  /// h5的地址
  final String initUrl;

  /// title名字
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  //
  WebViewController _webViewController;

  // 如果当前用户点击了html里的2个链接，则返回的时候，_listUrl不为空，则直接返回第一页显示的内容。
  final List<String> _listUrl = <String>[];

  @override
  void initState() {
    super.initState();
    print('lao_gao-->_WebViewPageState_initState_initUrl = ${widget.initUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print('lao_gao-->_WebViewPageState_build_ pop ${_listUrl.length}');
            if (_listUrl.isNotEmpty) {
              _loadLocalHTML();
              _listUrl.clear();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.initUrl,
        onPageStarted: (String url) {
          // print('lao_gao-->_WebViewPageState_build_${url}');
        },
        onPageFinished: (String url) {
          if (url.startsWith('https://optout.networkadvertising.org') |
              url.startsWith('https://www.adobe.com/privacy/opt-out.html')) {
            _listUrl.add(url);
          }
          print(
              'lao_gao-->_WebViewPageState_build_  end ---$url  -- ${_listUrl.length}');
        },
        // 需要添加这行，来启用JavaScript
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadLocalHTML();
        },
      ),
    );
  }

  Future<void> _loadLocalHTML() async {
    if (widget.path == null) {
      return;
    }
    final String fileHtmlContents = await rootBundle.loadString(widget.path);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
