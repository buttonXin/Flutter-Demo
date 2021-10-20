// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult _$HttpResultFromJson(Map<String, dynamic> json) {
  return HttpResult(
    success: json['success'] as bool?,
    data: json['data'],
    errorCode: json['errorCode'] as int?,
    errorMsg: json['errorMsg'] as String?,
  );
}

Map<String, dynamic> _$HttpResultToJson(HttpResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://nreal-public.nreal.ai/android/nebula/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResult> getInitData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/initData.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResult> getAppListData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/app_data_DT.json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResult> getAppListForPathData(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '$url',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
