import 'package:flutter/services.dart';

class LoginOutPlugin {
  static const String _pluginName = 'ai.nreal.nebula/account_login_logout';
  static const String _methodLogin = 'login';
  static const String _methodLogout = "logout";
  static const String _methodGetChannelInfoName = 'getChannelInfo';

  static final LoginOutPlugin _instance = LoginOutPlugin._internal();

  // ignore: sort_constructors_first
  factory LoginOutPlugin() {
    return _instance;
  }

  // ignore: sort_constructors_first
  LoginOutPlugin._internal();

  /// 登录
  Future<void> login(String countryData) async {
    final invokeMethod = await const MethodChannel(_pluginName)
        .invokeMethod(_methodLogin, countryData);
  }

  /// 登出
  Future<void> logout() async {
    final invokeMethod =
        await const MethodChannel(_pluginName).invokeMethod(_methodLogout);
  }

  /// 获取渠道的信息。
  Future<Map<String, String>> getChannelInfo() async {
    return await const MethodChannel(_pluginName)
        .invokeMapMethod<String, String>(_methodGetChannelInfoName);
  }
}
