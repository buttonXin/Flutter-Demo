import 'package:dio/dio.dart';
import 'package:flutter_github_demo/model/nebula_base_model.dart';
import 'package:flutter_github_demo/util/network_state.dart';

/// 请求前网络状态的判断
class NetworkConnectErrorInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('nebula_NetworkConnectErrorInterceptor.onRequest_111}');
    final bool connectResult = await NetworkState.isConnect();
    print('nebula_NetworkConnectErrorInterceptor.onRequest_222}');
    if (!connectResult) {
      handler.resolve(Response(
          requestOptions: options,
          data: HttpNebulaResult(
            success: false,
            code: 700,
            msg: 'NETWORK_NOT_CONNECTED',
          ).toJson()));
      return;
    }
    handler.next(options);
  }
}
