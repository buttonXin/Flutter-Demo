// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_github_demo/model/app_update_entity.dart';
import 'package:flutter_github_demo/generated/json/app_update_entity_helper.dart';
import 'package:flutter_github_demo/model/domain_info_entity.dart';
import 'package:flutter_github_demo/generated/json/domain_info_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case AppUpdateEntity:
				return appUpdateEntityFromJson(data as AppUpdateEntity, json) as T;
			case AppUpdateData:
				return appUpdateDataFromJson(data as AppUpdateData, json) as T;
			case AppUpdateDataBlacklistInfo:
				return appUpdateDataBlacklistInfoFromJson(data as AppUpdateDataBlacklistInfo, json) as T;
			case AppUpdateDataLatestVersion:
				return appUpdateDataLatestVersionFromJson(data as AppUpdateDataLatestVersion, json) as T;
			case AppUpdateDataCompulsoryUpgradeVersion:
				return appUpdateDataCompulsoryUpgradeVersionFromJson(data as AppUpdateDataCompulsoryUpgradeVersion, json) as T;
			case AppUpdateDataLatestServicePackage:
				return appUpdateDataLatestServicePackageFromJson(data as AppUpdateDataLatestServicePackage, json) as T;
			case DomainInfoEntity:
				return domainInfoEntityFromJson(data as DomainInfoEntity, json) as T;
			case DomainInfoNebula:
				return domainInfoNebulaFromJson(data as DomainInfoNebula, json) as T;
			case DomainInfoOthers:
				return domainInfoOthersFromJson(data as DomainInfoOthers, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case AppUpdateEntity:
				return appUpdateEntityToJson(data as AppUpdateEntity);
			case AppUpdateData:
				return appUpdateDataToJson(data as AppUpdateData);
			case AppUpdateDataBlacklistInfo:
				return appUpdateDataBlacklistInfoToJson(data as AppUpdateDataBlacklistInfo);
			case AppUpdateDataLatestVersion:
				return appUpdateDataLatestVersionToJson(data as AppUpdateDataLatestVersion);
			case AppUpdateDataCompulsoryUpgradeVersion:
				return appUpdateDataCompulsoryUpgradeVersionToJson(data as AppUpdateDataCompulsoryUpgradeVersion);
			case AppUpdateDataLatestServicePackage:
				return appUpdateDataLatestServicePackageToJson(data as AppUpdateDataLatestServicePackage);
			case DomainInfoEntity:
				return domainInfoEntityToJson(data as DomainInfoEntity);
			case DomainInfoNebula:
				return domainInfoNebulaToJson(data as DomainInfoNebula);
			case DomainInfoOthers:
				return domainInfoOthersToJson(data as DomainInfoOthers);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (AppUpdateEntity).toString()){
			return AppUpdateEntity().fromJson(json);
		}
		if(type == (AppUpdateData).toString()){
			return AppUpdateData().fromJson(json);
		}
		if(type == (AppUpdateDataBlacklistInfo).toString()){
			return AppUpdateDataBlacklistInfo().fromJson(json);
		}
		if(type == (AppUpdateDataLatestVersion).toString()){
			return AppUpdateDataLatestVersion().fromJson(json);
		}
		if(type == (AppUpdateDataCompulsoryUpgradeVersion).toString()){
			return AppUpdateDataCompulsoryUpgradeVersion().fromJson(json);
		}
		if(type == (AppUpdateDataLatestServicePackage).toString()){
			return AppUpdateDataLatestServicePackage().fromJson(json);
		}
		if(type == (DomainInfoEntity).toString()){
			return DomainInfoEntity().fromJson(json);
		}
		if(type == (DomainInfoNebula).toString()){
			return DomainInfoNebula().fromJson(json);
		}
		if(type == (DomainInfoOthers).toString()){
			return DomainInfoOthers().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<AppUpdateEntity>[] is M){
			return data.map<AppUpdateEntity>((e) => AppUpdateEntity().fromJson(e)).toList() as M;
		}
		if(<AppUpdateData>[] is M){
			return data.map<AppUpdateData>((e) => AppUpdateData().fromJson(e)).toList() as M;
		}
		if(<AppUpdateDataBlacklistInfo>[] is M){
			return data.map<AppUpdateDataBlacklistInfo>((e) => AppUpdateDataBlacklistInfo().fromJson(e)).toList() as M;
		}
		if(<AppUpdateDataLatestVersion>[] is M){
			return data.map<AppUpdateDataLatestVersion>((e) => AppUpdateDataLatestVersion().fromJson(e)).toList() as M;
		}
		if(<AppUpdateDataCompulsoryUpgradeVersion>[] is M){
			return data.map<AppUpdateDataCompulsoryUpgradeVersion>((e) => AppUpdateDataCompulsoryUpgradeVersion().fromJson(e)).toList() as M;
		}
		if(<AppUpdateDataLatestServicePackage>[] is M){
			return data.map<AppUpdateDataLatestServicePackage>((e) => AppUpdateDataLatestServicePackage().fromJson(e)).toList() as M;
		}
		if(<DomainInfoEntity>[] is M){
			return data.map<DomainInfoEntity>((e) => DomainInfoEntity().fromJson(e)).toList() as M;
		}
		if(<DomainInfoNebula>[] is M){
			return data.map<DomainInfoNebula>((e) => DomainInfoNebula().fromJson(e)).toList() as M;
		}
		if(<DomainInfoOthers>[] is M){
			return data.map<DomainInfoOthers>((e) => DomainInfoOthers().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}