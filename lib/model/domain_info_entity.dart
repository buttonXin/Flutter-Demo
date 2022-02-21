import 'package:flutter_github_demo/generated/json/base/json_convert_content.dart';

class DomainInfoEntity with JsonConvert<DomainInfoEntity> {
	DomainInfoNebula? nebula;
	DomainInfoOthers? others;
}

class DomainInfoNebula with JsonConvert<DomainInfoNebula> {
	String? uat;
	String? prod;
	String? test;
	String? dev;
}

class DomainInfoOthers with JsonConvert<DomainInfoOthers> {
	String? uat;
	String? prod;
	String? test;
	String? dev;
}
