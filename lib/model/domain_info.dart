// To parse this JSON data, do
//
//     final domainInfo = domainInfoFromJson(jsonString);

import 'dart:convert';

DomainInfo domainInfoFromJson(String str) =>
    DomainInfo.fromJson(json.decode(str));

String domainInfoToJson(DomainInfo data) => json.encode(data.toJson());

/// default domain
Map<String, dynamic> defaultDomain = {
  'code': 200,
  'msg': 'ok',
  'success': true,
  'data': {
    'nebula-internal-test': 'http://sequoia-api-test.nreal.work:31581',
    'nebula-internal-prod': 'http://sequoia-api.nreal.work:31581',
    'nebula-uat': 'https://app-uat-api.nreal.ai',
    'nebula-prod': 'https://app-api.nreal.ai',
    'default-uat': 'https://app-uat-api.nreal.ai',
    'default-prod': 'https://app-api.nreal.ai',
    'default-internal-test': 'http://sequoia-api-test.nreal.work:31581',
    'default-internal-prod': 'http://sequoia-api.nreal.work:31581'
  }
};

Map<String, dynamic> defaultDomain2 = {
  'code': 200,
  'msg': 'ok',
  'success': true,
  'data': {
    'ota': {
      'uat': '',
      'prod': '',
      'test': '',
      'dev': ''
    },
    'nebula': {
      'uat': '',
      'prod': '',
      'test': '',
      'dev': ''
    },
    'default': {
      'uat': 'https://app-uat-api.nreal.ai',
      'prod': 'https://app-api.nreal.ai',
      'test': 'http://sequoia-api.nreal.work:31581',
      'dev': 'http://sequoia-api-test.nreal.work:31581'
    }
  }
};

/// 请求所有域名的bean类
class DomainInfo {
  DomainInfo({
    // 内网测试
    this.nebulaInternalTest,
    // 内网生产
    this.nebulaInternalProd,
    // 外网测试
    this.nebulaUat,
    // 外网生产
    this.nebulaProd,
    // 默认外网测试
    this.defaultUat,
    // 默认外网生产
    this.defaultProd,
    // 默认内网测试
    this.defaultInternalTest,
    // 默认内网生产
    this.defaultInternalProd,
  });

  factory DomainInfo.fromJson(Map<String, dynamic> json) => DomainInfo(
        nebulaInternalTest: json['nebula-internal-test'],
        nebulaInternalProd: json['nebula-internal-prod'],
        nebulaUat: json['nebula-uat'],
        nebulaProd: json['nebula-prod'],
        defaultUat: json['default-uat'],
        defaultProd: json['default-prod'],
        defaultInternalTest: json['default-internal-test'],
        defaultInternalProd: json['default-internal-prod'],
      );
  String? nebulaInternalTest;
  String? nebulaInternalProd;
  String? nebulaUat;
  String? nebulaProd;
  String? defaultUat;
  String? defaultProd;
  String? defaultInternalTest;
  String? defaultInternalProd;

  Map<String, dynamic> toJson() => {
        'nebula-internal-test': nebulaInternalTest,
        'nebula-internal-prod': nebulaInternalProd,
        'nebula-uat': nebulaUat,
        'nebula-prod': nebulaProd,
        'default-uat': defaultUat,
        'default-prod': defaultProd,
        'default-internal-test': defaultInternalTest,
        'default-internal-prod': defaultInternalProd,
      };
}
