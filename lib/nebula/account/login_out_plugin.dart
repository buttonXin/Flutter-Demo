import 'package:flutter/services.dart';

class LoginOutPlugin {
  static const String _pluginName = 'ai.nreal.nebula/account_login_logout';
  static const EventChannel _pluginEventName =
      EventChannel('ai.nreal.nebula/account_info_event');
  static const String _methodLogin = 'login';
  static const String _methodLogout = 'logout';
  static const String _methodUpdateUser = 'updateUser';

  // 获取与更新用户的返回值标记
  static const String GET_USER = 'getUser';
  static const String UPDATE_USER = 'updateUser';

  static final LoginOutPlugin _instance = LoginOutPlugin._internal();

  // ignore: sort_constructors_first
  factory LoginOutPlugin() {
    return _instance;
  }

  // ignore: sort_constructors_first
  LoginOutPlugin._internal() {
    _pluginEventName
        .receiveBroadcastStream()
        .listen(_onEvent, onError: _onError);
  }

  /// 登录
  Future<void> login(String? countryData) async {
    await const MethodChannel(_pluginName)
        .invokeMethod(_methodLogin, countryData);
  }

  /// 登出
  Future<void> logout() async {
    await const MethodChannel(_pluginName).invokeMethod(_methodLogout);
  }

  /// 更新数据
  Future<void> updateUserInfo({Map<dynamic, dynamic>? userMetadata}) async {
    final Map<dynamic, dynamic> userMetadata = {};
    userMetadata['nickname'] = 'nickname2';
    userMetadata['gender'] = 'woman';
    userMetadata['distance'] = 741.0;
    userMetadata['birth'] = 852.0;
    await const MethodChannel(_pluginName)
        .invokeMethod(_methodUpdateUser, userMetadata);
  }

  void _onEvent(dynamic event) {
    if (GET_USER == event[GET_USER]) {
      _getUserInfo(event);
      return;
    }

    if (UPDATE_USER == event[UPDATE_USER]) {
      _updateUserInfo(event);
      return;
    }
  }

  void _onError(dynamic mapEvent) {}

  void _getUserInfo(dynamic event) {
    final String? error = event['error'];
    if (error != null && error.isNotEmpty) {
      print('lao_gao-->LoginOutPlugin__onEvent_$error');
      return;
    }
    final String? email = event['email'];
    final Map<dynamic, dynamic> userMetadata = event['userMetadata'];
    String? nickname = userMetadata['nickname'];
    String? gender = userMetadata['gender'];
    double? distance = userMetadata['distance'];
    double? birth = userMetadata['birth'];
    print('lao_gao-->LoginOutPlugin__onEvent_${event.toString()}');
  }

  void _updateUserInfo(dynamic event) {
    final String? error = event['error'];
    if (error != null && error.isNotEmpty) {
      print('lao_gao-->LoginOutPlugin__onEvent_$error');
      return;
    }
  }
}
