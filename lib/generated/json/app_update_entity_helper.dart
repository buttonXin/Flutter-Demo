import 'package:flutter_github_demo/model/app_update_entity.dart';

appUpdateEntityFromJson(AppUpdateEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['success'] != null) {
		data.success = json['success'];
	}
	if (json['data'] != null) {
		data.data = AppUpdateData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> appUpdateEntityToJson(AppUpdateEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['success'] = entity.success;
	data['data'] = entity.data?.toJson();
	data['msg'] = entity.msg;
	return data;
}

appUpdateDataFromJson(AppUpdateData data, Map<String, dynamic> json) {
	if (json['blacklistInfo'] != null) {
		data.blacklistInfo = AppUpdateDataBlacklistInfo().fromJson(json['blacklistInfo']);
	}
	if (json['isUpgrade'] != null) {
		data.isUpgrade = json['isUpgrade'];
	}
	if (json['latestVersion'] != null) {
		data.latestVersion = AppUpdateDataLatestVersion().fromJson(json['latestVersion']);
	}
	if (json['compulsoryUpgradeVersion'] != null) {
		data.compulsoryUpgradeVersion = AppUpdateDataCompulsoryUpgradeVersion().fromJson(json['compulsoryUpgradeVersion']);
	}
	if (json['latestServicePackage'] != null) {
		data.latestServicePackage = AppUpdateDataLatestServicePackage().fromJson(json['latestServicePackage']);
	}
	return data;
}

Map<String, dynamic> appUpdateDataToJson(AppUpdateData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['blacklistInfo'] = entity.blacklistInfo?.toJson();
	data['isUpgrade'] = entity.isUpgrade;
	data['latestVersion'] = entity.latestVersion?.toJson();
	data['compulsoryUpgradeVersion'] = entity.compulsoryUpgradeVersion?.toJson();
	data['latestServicePackage'] = entity.latestServicePackage?.toJson();
	return data;
}

appUpdateDataBlacklistInfoFromJson(AppUpdateDataBlacklistInfo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['level'] != null) {
		data.level = json['level'] is String
				? int.tryParse(json['level'])
				: json['level'].toInt();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'].toString();
	}
	if (json['isBlacklist'] != null) {
		data.isBlacklist = json['isBlacklist'];
	}
	return data;
}

Map<String, dynamic> appUpdateDataBlacklistInfoToJson(AppUpdateDataBlacklistInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['level'] = entity.level;
	data['createTime'] = entity.createTime;
	data['isBlacklist'] = entity.isBlacklist;
	return data;
}

appUpdateDataLatestVersionFromJson(AppUpdateDataLatestVersion data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['versionCode'] != null) {
		data.versionCode = json['versionCode'] is String
				? int.tryParse(json['versionCode'])
				: json['versionCode'].toInt();
	}
	if (json['versionName'] != null) {
		data.versionName = json['versionName'].toString();
	}
	if (json['versionType'] != null) {
		data.versionType = json['versionType'].toString();
	}
	if (json['packageId'] != null) {
		data.packageId = json['packageId'].toString();
	}
	if (json['servicePackageName'] != null) {
		data.servicePackageName = json['servicePackageName'].toString();
	}
	if (json['nebulaPackageName'] != null) {
		data.nebulaPackageName = json['nebulaPackageName'].toString();
	}
	if (json['packageUrl'] != null) {
		data.packageUrl = json['packageUrl'].toString();
	}
	return data;
}

Map<String, dynamic> appUpdateDataLatestVersionToJson(AppUpdateDataLatestVersion entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['versionCode'] = entity.versionCode;
	data['versionName'] = entity.versionName;
	data['versionType'] = entity.versionType;
	data['packageId'] = entity.packageId;
	data['servicePackageName'] = entity.servicePackageName;
	data['nebulaPackageName'] = entity.nebulaPackageName;
	data['packageUrl'] = entity.packageUrl;
	return data;
}

appUpdateDataCompulsoryUpgradeVersionFromJson(AppUpdateDataCompulsoryUpgradeVersion data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['versionCode'] != null) {
		data.versionCode = json['versionCode'] is String
				? int.tryParse(json['versionCode'])
				: json['versionCode'].toInt();
	}
	if (json['versionName'] != null) {
		data.versionName = json['versionName'].toString();
	}
	if (json['versionType'] != null) {
		data.versionType = json['versionType'].toString();
	}
	if (json['packageId'] != null) {
		data.packageId = json['packageId'].toString();
	}
	if (json['servicePackageName'] != null) {
		data.servicePackageName = json['servicePackageName'].toString();
	}
	if (json['nebulaPackageName'] != null) {
		data.nebulaPackageName = json['nebulaPackageName'].toString();
	}
	if (json['packageUrl'] != null) {
		data.packageUrl = json['packageUrl'].toString();
	}
	return data;
}

Map<String, dynamic> appUpdateDataCompulsoryUpgradeVersionToJson(AppUpdateDataCompulsoryUpgradeVersion entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['versionCode'] = entity.versionCode;
	data['versionName'] = entity.versionName;
	data['versionType'] = entity.versionType;
	data['packageId'] = entity.packageId;
	data['servicePackageName'] = entity.servicePackageName;
	data['nebulaPackageName'] = entity.nebulaPackageName;
	data['packageUrl'] = entity.packageUrl;
	return data;
}

appUpdateDataLatestServicePackageFromJson(AppUpdateDataLatestServicePackage data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['versionCode'] != null) {
		data.versionCode = json['versionCode'] is String
				? int.tryParse(json['versionCode'])
				: json['versionCode'].toInt();
	}
	if (json['versionName'] != null) {
		data.versionName = json['versionName'].toString();
	}
	if (json['versionType'] != null) {
		data.versionType = json['versionType'].toString();
	}
	if (json['packageId'] != null) {
		data.packageId = json['packageId'].toString();
	}
	if (json['servicePackageName'] != null) {
		data.servicePackageName = json['servicePackageName'].toString();
	}
	if (json['nebulaPackageName'] != null) {
		data.nebulaPackageName = json['nebulaPackageName'].toString();
	}
	if (json['packageUrl'] != null) {
		data.packageUrl = json['packageUrl'].toString();
	}
	return data;
}

Map<String, dynamic> appUpdateDataLatestServicePackageToJson(AppUpdateDataLatestServicePackage entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['versionCode'] = entity.versionCode;
	data['versionName'] = entity.versionName;
	data['versionType'] = entity.versionType;
	data['packageId'] = entity.packageId;
	data['servicePackageName'] = entity.servicePackageName;
	data['nebulaPackageName'] = entity.nebulaPackageName;
	data['packageUrl'] = entity.packageUrl;
	return data;
}