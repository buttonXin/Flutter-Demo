import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class HttpDownloadFile {
  static final HttpDownloadFile _instance = HttpDownloadFile._internal();

  Dio _dio = Dio();

  factory HttpDownloadFile() {
    return _instance;
  }

  HttpDownloadFile._internal() {
    _dio.interceptors.add(LogInterceptor());
  }

  Map<String, List<StreamController<double>>> _mapStream = {};
  Map<String, StreamController<DownloadResult>> _mapStream222 = {};

  ///同一个CancelToken可以用于多个请求，
  ///当一个CancelToken取消时，所有使用该CancelToken的请求都会被取消
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();
  Map<String, DownloadResult> _mapDownloadStatus =
      Map<String, DownloadResult>();

  void addStreamController(String url, StreamController controller) {
    if (_mapStream[url] == null) {
      _mapStream[url] = [controller];
    } else {
      _mapStream[url].add(controller);
    }
  }

  void removeStreamController(String url, StreamController controller) {
    if (_mapStream[url] != null) {
      controller.close();
      _mapStream[url].remove(controller);
    }
  }

  /// 开始下载文件，需要传入
  /// [url] 下载路径，必传
  /// [fileNameApk] 文件的名字，也是必传的
  StreamController startDownloadFile(String url, String fileNameApk) {
    if (_mapStream222[url] == null) {
      _mapStream222[url] = StreamController.broadcast()
        ..add(DownloadResult()..downloadStatus = DownloadStatus.init);
      _cancelTokens[url] = CancelToken();
      _mapDownloadStatus[url] = DownloadResult();

      _dioDownloadFile(url, fileNameApk);
    }
    return _mapStream222[url];
  }

  /// 在sdcard的Android下的包名路径下创建文件
  Future<String> _createFile(String fileName) async {
    String dirFile = "";
    if (Platform.isAndroid) {
//      dirFile = "/sdcard/nreal_ai";
      dirFile = (await getExternalStorageDirectory()).path;
      print('lao_gao--> ${dirFile}');
    } else {
      dirFile = (await getApplicationDocumentsDirectory()).path;
    }

    File file = File(dirFile + "/$fileName");
    if (!file.existsSync()) {
      file.createSync();
      print('lao_gao-->file--> ${file.path}');
    }

    return file.path;
  }

  /// 使用dio的下载
  void _dioDownloadFile(String url, String fileNameApk) async {
    try {
      String dirFile = await _createFile(fileNameApk);
      //3、使用 dio 下载文件
      final cancelToken = _cancelTokens[url];

      final response = await _dio.download(url, dirFile,
          cancelToken: cancelToken, onReceiveProgress: (int count, int total) {
        final mapDownloadStatus = _mapDownloadStatus[url];
        mapDownloadStatus.progress = count / total;
        if (mapDownloadStatus.progress == 1) {
          mapDownloadStatus.downloadStatus = DownloadStatus.complete;
          mapDownloadStatus.fileName = dirFile;
        } else {
          mapDownloadStatus.downloadStatus = DownloadStatus.loading;
        }
        _mapStream222[url].add(mapDownloadStatus);
      });

      print('laogao--> ${response}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('lao_gao--> ${e.message}');

        final StreamController<DownloadResult> streamController =
            _mapStream222[e.message];
        if (streamController != null && !streamController.isClosed) {
          streamController.close();
          _mapStream222.remove(e.message);
        }
      }
    } catch (e) {
      print("lao_gao--> 未知异常出错：$e");
    }
  }

  /// 如果当前的view需要下载的回调，则通过传入对应的url来获取StreamController
  StreamController<DownloadResult> getStreamController(String url) {
    return _mapStream222[url];
  }

  void cancelDownload(String url) {
    _cancelTokens[url]?.cancel(url);
    _cancelTokens.remove(url);
    final StreamController<DownloadResult> streamController =
        _mapStream222[url];
    streamController.add(_mapDownloadStatus[url]..downloadStatus = DownloadStatus.cancel);
  }
}

enum DownloadStatus {
  init,
  loading,
  complete,
  cancel,
}

class DownloadResult {
  double progress = 0;
  DownloadStatus downloadStatus;
  String fileName;

}
