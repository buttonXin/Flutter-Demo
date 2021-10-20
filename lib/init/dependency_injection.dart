import 'package:dio/dio.dart';
import 'package:flutter_github_demo/model/base_model.dart';
import 'package:flutter_github_demo/model/nebula_base_model.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // dio init
    final Dio _dio = Dio();
    _dio.options.connectTimeout = 15000;
    _dio.options.receiveTimeout = 15000;
    const bool inProduction = bool.fromEnvironment('dart.vm.product');
    if (!inProduction) {
      _dio.interceptors.add(LogInterceptor());
    }
    Get.put(RestClient(_dio));


    Get.put(NebulaRestClient(_dio));




    // other init
  }
}
