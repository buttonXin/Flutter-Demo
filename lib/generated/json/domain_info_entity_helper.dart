import 'package:flutter_github_demo/model/domain_info_entity.dart';

domainInfoEntityFromJson(DomainInfoEntity data, Map<String, dynamic> json) {
	if (json['nebula'] != null) {
		data.nebula = DomainInfoNebula().fromJson(json['nebula']);
	}
	if (json['others'] != null) {
		data.others = DomainInfoOthers().fromJson(json['others']);
	}
	return data;
}

Map<String, dynamic> domainInfoEntityToJson(DomainInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['nebula'] = entity.nebula?.toJson();
	data['others'] = entity.others?.toJson();
	return data;
}

domainInfoNebulaFromJson(DomainInfoNebula data, Map<String, dynamic> json) {
	if (json['uat'] != null) {
		data.uat = json['uat'].toString();
	}
	if (json['prod'] != null) {
		data.prod = json['prod'].toString();
	}
	if (json['test'] != null) {
		data.test = json['test'].toString();
	}
	if (json['dev'] != null) {
		data.dev = json['dev'].toString();
	}
	return data;
}

Map<String, dynamic> domainInfoNebulaToJson(DomainInfoNebula entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uat'] = entity.uat;
	data['prod'] = entity.prod;
	data['test'] = entity.test;
	data['dev'] = entity.dev;
	return data;
}

domainInfoOthersFromJson(DomainInfoOthers data, Map<String, dynamic> json) {
	if (json['uat'] != null) {
		data.uat = json['uat'].toString();
	}
	if (json['prod'] != null) {
		data.prod = json['prod'].toString();
	}
	if (json['test'] != null) {
		data.test = json['test'].toString();
	}
	if (json['dev'] != null) {
		data.dev = json['dev'].toString();
	}
	return data;
}

Map<String, dynamic> domainInfoOthersToJson(DomainInfoOthers entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uat'] = entity.uat;
	data['prod'] = entity.prod;
	data['test'] = entity.test;
	data['dev'] = entity.dev;
	return data;
}