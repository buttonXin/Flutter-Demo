import 'package:dio/dio.dart';
import 'package:flutter_github_demo/model/base_model.dart';
import 'package:flutter_github_demo/model/domain_info.dart';
import 'package:flutter_github_demo/model/nebula_base_model.dart';
import 'package:flutter_github_demo/util/L.dart';
import 'package:get/get.dart';

import 'network_connect_error.dart';

class DependencyInjection {
  static Future<void> init() async {
    // dio init
    final Dio _dio = Dio();
    _dio.options.connectTimeout = 15000;
    _dio.options.receiveTimeout = 15000;
    const bool inProduction = bool.fromEnvironment('dart.vm.product');
    _dio.interceptors.add(LogInterceptor());

    _dio.interceptors.add(NetworkConnectErrorInterceptor());

    _dio.options.baseUrl = 'http://sequoia-api-test.nreal.work:31581';
    // _dio.options.baseUrl = 'http://192.168.70.210:8080';
    final NebulaRestClient nebulaRestClient = NebulaRestClient(_dio);
    Get.put(nebulaRestClient);
    // HttpNebulaResult httpNebulaResult = await nebulaRestClient.getDomainList();
    //
    // L.e('DependencyInjection.init_httpNebulaResult = $httpNebulaResult');
    // // httpNebulaResult = HttpNebulaResult.fromJson(defaultDomain);
    // if (httpNebulaResult.success != null && httpNebulaResult.success!) {
    //   L.e('DependencyInjection.init_${httpNebulaResult.success!}');
    // }
    // L.e('DependencyInjection.init_${httpNebulaResult.success!}');
    //
    // if (!httpNebulaResult.success!) {
    //   httpNebulaResult = HttpNebulaResult.fromJson(defaultDomain);
    // }
    //
    // final DomainInfo domainInfo = DomainInfo.fromJson(httpNebulaResult.data);
    //
    // final String? defaultInternalTest = domainInfo.nebulaInternalTest;
    //
    // L.e('DependencyInjection.init_$defaultInternalTest');
    // _dio.options.baseUrl =
    //     defaultInternalTest ?? 'http://sequoia-api-test.nreal.work:31581/';
    //
    Get.put(nebulaRestClient);

    RestClient restClient = RestClient(_dio);
    Get.put(restClient);

    Log.e('app init');
    // other init
  }

  static Future<void> domainInit() async {
    await init();
  }
}
