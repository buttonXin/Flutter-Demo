import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'nebula_base_model.g.dart';

/// 增加接口后或者修改接口参数等操作后 ，需要在命令行执行： flutter pub run build_runner build
/// ！！！！！！！！！
@RestApi(
    baseUrl: 'http://sequoia-api-test.nreal.work:31581/')
abstract class NebulaRestClient {
  factory NebulaRestClient(Dio dio, {String baseUrl}) = _NebulaRestClient;


  @GET('api/mrlab-appstore/isc/admin/software/version/check')
  Future<HttpNebulaResult> getAppVersion({
    @Query('currentVersionCode') required int? currentVersionCode,
    @Query('currentServiceModel') required String? currentServiceModel,
    @Query('currentPackageName') required String? currentPackageName,
    @Query('hardwareCode') String? hardwareCode,
    @Query('operatorCode') String? operatorCode,
    @Query('operatorCountryCode') String? operatorCountryCode,
    @Query('versionCode') int? versionCode,
  });

  @GET('{pathUrl}')
  Future<HttpNebulaResult> getDataForUrl(@Path('pathUrl') String url);
}

@JsonSerializable()
class HttpNebulaResult {
  HttpNebulaResult({this.success, this.data, this.code, this.msg});

  bool? success;
  dynamic data;
  int? code;
  String? msg;

  factory HttpNebulaResult.fromJson(Map<String, dynamic> json) =>
      _$HttpNebulaResultFromJson(json);

  Map<String, dynamic> toJson() => _$HttpNebulaResultToJson(this);

  @override
  String toString() {
    return 'HttpResult{success: $success, data: $data, errorCode: $code, errorMsg: $msg}';
  }
}
