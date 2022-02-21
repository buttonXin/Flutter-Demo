import 'package:flutter_github_demo/generated/json/base/json_convert_content.dart';

class AppUpdateEntity with JsonConvert<AppUpdateEntity> {
	int? code;
	bool? success;
	AppUpdateData? data;
	String? msg;
}

class AppUpdateData with JsonConvert<AppUpdateData> {
	AppUpdateDataBlacklistInfo? blacklistInfo;
	bool? isUpgrade;
	AppUpdateDataLatestVersion? latestVersion;
	AppUpdateDataCompulsoryUpgradeVersion? compulsoryUpgradeVersion;
	AppUpdateDataLatestServicePackage? latestServicePackage;
}

class AppUpdateDataBlacklistInfo with JsonConvert<AppUpdateDataBlacklistInfo> {
	String? id;
	String? name;
	int? level;
	String? createTime;
	bool? isBlacklist;
}

class AppUpdateDataLatestVersion with JsonConvert<AppUpdateDataLatestVersion> {
	int? id;
	int? versionCode;
	String? versionName;
	String? versionType;
	String? packageId;
	String? servicePackageName;
	String? nebulaPackageName;
	String? packageUrl;
}

class AppUpdateDataCompulsoryUpgradeVersion with JsonConvert<AppUpdateDataCompulsoryUpgradeVersion> {
	int? id;
	int? versionCode;
	String? versionName;
	String? versionType;
	String? packageId;
	String? servicePackageName;
	String? nebulaPackageName;
	String? packageUrl;
}

class AppUpdateDataLatestServicePackage with JsonConvert<AppUpdateDataLatestServicePackage> {
	int? id;
	int? versionCode;
	String? versionName;
	String? versionType;
	String? packageId;
	String? servicePackageName;
	String? nebulaPackageName;
	String? packageUrl;
}
