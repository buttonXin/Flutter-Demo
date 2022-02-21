import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

/// 网络状态的工具类
mixin NetworkState {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> isConnect() async {
    try {
      final ConnectivityResult result = await _connectivity.checkConnectivity();
      print('nebula_NetworkState.isConnect_result = $result');
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print('exception: ${e.message}');
      return false;
    }
  }

//  static Future<ConnectivityResult> connectType() async {
//    try {
//      ConnectivityResult result = await _connectivity.checkConnectivity();
//      return result;
//    } on PlatformException catch (e) {
//      print('exception: ${e.message}');
//      return ConnectivityResult.none;
//    }
//  }

  /// true   表示wifi
  /// false  表示 mobile
  static Future<bool> connectType() async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.wifi) {
        return true;
      } else if (result == ConnectivityResult.mobile) {
        return false;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print('exception: ${e.message}');
      return false;
    }
  }
}
