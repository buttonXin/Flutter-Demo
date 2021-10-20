
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'base_model.g.dart';

/// 增加接口后，需要在命令行执行： flutter pub run build_runner build
///
@RestApi(baseUrl: 'https://nreal-public.nreal.ai/android/nebula/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/initData.json')
  Future<HttpResult> getInitData();

  @GET('/app_data_DT.json')
  Future<HttpResult> getAppListData();

  @GET('{pathUrl}')
  Future<HttpResult> getAppListForPathData(@Path('pathUrl') String url);
}

@JsonSerializable()
class HttpResult {
  HttpResult({this.success, this.data, this.errorCode, this.errorMsg});

  bool? success;
  dynamic data;
  int? errorCode;
  String? errorMsg;

  factory HttpResult.fromJson(Map<String, dynamic> json) =>
      _$HttpResultFromJson(json);

  Map<String, dynamic> toJson() => _$HttpResultToJson(this);

  @override
  String toString() {
    return 'HttpResult{success: $success, data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
  }
}

class InitDataBean {
  InitDataBean({
    this.versionInfo,
    this.obb,
    this.operatorAppList,
    this.webAppList,
  });

  VersionInfo? versionInfo;
  String? obb;
  List<OperatorAppInfo>? operatorAppList;
  List<WebAppInfo>? webAppList;

  factory InitDataBean.fromJson(Map<String, dynamic> json) => InitDataBean(
        versionInfo: VersionInfo.fromJson(json['versionInfo']),
        obb: json['obb'],
        operatorAppList: List<OperatorAppInfo>.from(
            json['operatorAppList'].map((x) => OperatorAppInfo.fromJson(x))),
        webAppList: List<WebAppInfo>.from(
            json['webAppList'].map((x) => WebAppInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'versionInfo': versionInfo!.toJson(),
        'obb': obb,
        'operatorAppList':
            List<dynamic>.from(operatorAppList!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'InitDataBean{versionInfo: $versionInfo, obb: $obb, operatorAppList: $operatorAppList}';
  }
}

class OperatorAppInfo {
  OperatorAppInfo({
    this.operator,
    this.code,
    this.listUrl,
  });

  String? operator;
  int? code;
  String? listUrl;

  factory OperatorAppInfo.fromJson(Map<String, dynamic> json) =>
      OperatorAppInfo(
        operator: json['operator'],
        code: json['code'],
        listUrl: json['listUrl'],
      );

  Map<String, dynamic> toJson() => {
        'operator': operator,
        'code': code,
        'listUrl': listUrl,
      };

  @override
  String toString() {
    return 'OperatorAppList{operatorAppListOperator: $operator, code: $code, listUrl: $listUrl}';
  }
}

class WebAppInfo {
  WebAppInfo({
    this.countryIso,
    this.listUrl,
  });

  String? countryIso;
  String? listUrl;

  factory WebAppInfo.fromJson(Map<String, dynamic> json) => WebAppInfo(
        countryIso: json['countryIso'],
        listUrl: json['listUrl'],
      );

  Map<String, dynamic> toJson() => {
        'countryIso': countryIso,
        'listUrl': listUrl,
      };

  @override
  String toString() {
    return 'OperatorAppList{operatorAppListOperator: $countryIso, listUrl: $listUrl}';
  }
}

class VersionInfo {
  VersionInfo({
    this.kddiServiceModels,
    this.serviceModels,
    this.whiteModels,
    this.blackModels,
    this.weakBlackModels,
    this.nebula,
    this.service,
    this.otherModel,
  });

  List<String>? kddiServiceModels;
  List<String>? serviceModels;
  List<String>? whiteModels;
  List<String>? blackModels;
  List<String>? weakBlackModels;
  List<NebulaBean>? nebula;
  List<NebulaBean>? service;
  bool? otherModel;

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        kddiServiceModels:
            List<String>.from(json['kddiServiceModels'].map((x) => x)),
        serviceModels: List<String>.from(json['serviceModels'].map((x) => x)),
        whiteModels: List<String>.from(json['whiteModels'].map((x) => x)),
        blackModels: List<String>.from(json['blackModels'].map((x) => x)),
        weakBlackModels:
            List<String>.from(json['weakBlackModels'].map((x) => x)),
        otherModel: json['otherModel'],
        nebula: List<NebulaBean>.from(
            json['nebula'].map((x) => NebulaBean.fromJson(x))),
        service: List<NebulaBean>.from(
            json['service'].map((x) => NebulaBean.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'kddiServiceModels':
            List<dynamic>.from(kddiServiceModels!.map((String x) => x)),
        'serviceModels':
            List<dynamic>.from(serviceModels!.map((String x) => x)),
        'whiteModels': List<dynamic>.from(whiteModels!.map((String x) => x)),
        'blackModels': List<dynamic>.from(blackModels!.map((String x) => x)),
        'weakBlackModels':
            List<dynamic>.from(weakBlackModels!.map((String x) => x)),
        'nebula': List<dynamic>.from(nebula!.map((x) => x.toJson())),
        'service': List<dynamic>.from(service!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'VersionInfo{nebula: $nebula, service: $service}';
  }
}

class NebulaBean {
  NebulaBean({
    this.brand,
    this.nebulaName,
    this.serviceName,
    this.versionCode,
    this.nebulaUrl,
    this.googleUrl,
  });

  String? brand;
  String? nebulaName;
  String? serviceName;
  int? versionCode;
  String? nebulaUrl;
  String? googleUrl;

  factory NebulaBean.fromJson(Map<String, dynamic> json) => NebulaBean(
        brand: json['brand'],
        nebulaName: json['nebulaName'],
        serviceName: json['serviceName'],
        versionCode: json['versionCode'],
        nebulaUrl: json['nebulaUrl'],
        googleUrl: json['GoogleUrl'],
      );

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'nebulaName': nebulaName,
        'serviceName': serviceName,
        'versionCode': versionCode,
        'nebulaUrl': nebulaUrl,
        'GoogleUrl': googleUrl,
      };

  @override
  String toString() {
    return 'Nebula{brand: $brand, nebulaName: $nebulaName, serviceName: $serviceName, versionCode: $versionCode, nebulaUrl: $nebulaUrl, googleUrl: $googleUrl}';
  }
}
