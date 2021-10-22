// To parse this JSON data, do
//
//     final appUpdateInfo = appUpdateInfoFromJson(jsonString);

import 'dart:convert';

AppUpdateInfo appUpdateInfoFromJson(String str) =>
    AppUpdateInfo.fromJson(json.decode(str));

String appUpdateInfoToJson(AppUpdateInfo data) => json.encode(data.toJson());

class AppUpdateInfo {
  AppUpdateInfo({
    this.blacklistInfo,
    this.isUpgrade,
    this.latestServicePackage,
    this.latestVersion,
  });

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) => AppUpdateInfo(
        blacklistInfo: BlacklistInfo.fromJson(json['blacklistInfo']),
        isUpgrade: json['isUpgrade'],
        latestServicePackage:
            CompulsoryUpgradeVersion.fromJson(json['latestServicePackage']),
        latestVersion: CompulsoryUpgradeVersion.fromJson(json['latestVersion']),
      );

  BlacklistInfo? blacklistInfo;
  bool? isUpgrade;
  CompulsoryUpgradeVersion? latestServicePackage;
  CompulsoryUpgradeVersion? latestVersion;

  Map<String, dynamic> toJson() => {
        'blacklistInfo': blacklistInfo!.toJson(),
        'isUpgrade': isUpgrade,
        'latestServicePackage': latestServicePackage!.toJson(),
        'latestVersion': latestVersion!.toJson(),
      };
}

class BlacklistInfo {
  BlacklistInfo({
    this.isBlacklist,
    this.level,
    this.name,
  });

  factory BlacklistInfo.fromJson(Map<String, dynamic> json) => BlacklistInfo(
        isBlacklist: json['isBlacklist'],
        level: json['level'],
        name: json['name'],
      );

  bool? isBlacklist;
  int? level;
  String? name;

  Map<String, dynamic> toJson() => {
        'isBlacklist': isBlacklist,
        'level': level,
        'name': name,
      };
}

class CompulsoryUpgradeVersion {
  CompulsoryUpgradeVersion({
    this.id,
    this.nebulaPackageName,
    this.packageId,
    this.packageUrl,
    this.servicePackageName,
    this.versionCode,
    this.versionName,
    this.versionType,
  });

  factory CompulsoryUpgradeVersion.fromJson(Map<String, dynamic> json) =>
      CompulsoryUpgradeVersion(
        id: json['id'],
        nebulaPackageName: json['nebulaPackageName'],
        packageId: json['packageId'],
        packageUrl: json['packageUrl'],
        servicePackageName: json['servicePackageName'],
        versionCode: json['versionCode'],
        versionName: json['versionName'],
        versionType: json['versionType'],
      );

  int? id;
  String? nebulaPackageName;
  String? packageId;
  String? packageUrl;
  String? servicePackageName;
  int? versionCode;
  String? versionName;
  String? versionType;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nebulaPackageName': nebulaPackageName,
        'packageId': packageId,
        'packageUrl': packageUrl,
        'servicePackageName': servicePackageName,
        'versionCode': versionCode,
        'versionName': versionName,
        'versionType': versionType,
      };
}
