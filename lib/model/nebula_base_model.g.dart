// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nebula_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpNebulaResult _$HttpNebulaResultFromJson(Map<String, dynamic> json) {
  return HttpNebulaResult(
    success: json['success'] as bool?,
    data: json['data'],
    code: json['code'] as int?,
    msg: json['msg'] as String?,
  );
}

Map<String, dynamic> _$HttpNebulaResultToJson(HttpNebulaResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'code': instance.code,
      'msg': instance.msg,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NebulaRestClient implements NebulaRestClient {
  _NebulaRestClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpNebulaResult> getAppVersion(
      {currentVersionCode,
      currentServiceModel,
      currentPackageName,
      hardwareCode,
      operatorCode,
      operatorCountryCode,
      versionCode,
      header = 'nebula'}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'currentVersionCode': currentVersionCode,
      r'currentServiceModel': currentServiceModel,
      r'currentPackageName': currentPackageName,
      r'hardwareCode': hardwareCode,
      r'operatorCode': operatorCode,
      r'operatorCountryCode': operatorCountryCode,
      r'versionCode': versionCode
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpNebulaResult>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Application': header},
                extra: _extra)
            .compose(
                _dio.options, '/api/nebula/v1/isc/admin/software/version/check',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpNebulaResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpNebulaResult> getDomainList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpNebulaResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/serverlist',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpNebulaResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpNebulaResult> getDataForUrl(url) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpNebulaResult>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '$url',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HttpNebulaResult.fromJson(_result.data!);
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
