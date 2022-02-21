import 'package:flutter_github_demo/model/app_update_info.dart';
import 'package:flutter_github_demo/model/base_model.dart';
import 'package:flutter_github_demo/model/domain_info_entity.dart';
import 'package:flutter_github_demo/model/nebula_base_model.dart';
import 'package:flutter_github_demo/util/L.dart';
import 'package:get/get.dart';

class RetrofitDemoLogic extends GetxController {
  final RestClient client = Get.find<RestClient>();
  final NebulaRestClient clientNebula = Get.find<NebulaRestClient>();

  @override
  void dispose() {
    Get.delete<RetrofitDemoLogic>(force: true);
    super.dispose();
  }

  void getInitData() {
    client.getInitData().then((HttpResult httpResult) {
      Log.e(httpResult.toString());

      final InitDataBean infoData = InitDataBean.fromJson(httpResult.data);

      Log.e(infoData.versionInfo!.nebula![0].nebulaName);

      Log.e('ok');
    });

    Log.e('line');
    client.getAppListData().then((HttpResult httpResult) {
      final Map<String, dynamic> data = httpResult.data;

      Log.e(data['app_list']);
      Log.e('ok');
    });

    client
        .getAppListForPathData(
            'https://nreal-public.nreal.ai/android/nebula/app_data_DT.json')
        .then((HttpResult httpResult) {
      final Map<String, dynamic> data = httpResult.data;
      Log.e('url-->');
      final data2 = data['app_list'];
      Log.e('url---> $data2');
      Log.e('ok');
    });
  }

  void getDomainList() {
    clientNebula
        .getDataForUrl('https://api.nreal.ai/v2/serverlist')
        .then((HttpNebulaResult result) {
      Log.e('--getDomainList--> $result');

      final DomainInfoEntity domainInfo2Entity =
          DomainInfoEntity().fromJson(result.data);

      Log.d('getDomainList_${domainInfo2Entity.others!.uat}');
      Log.d('getDomainList_${domainInfo2Entity.nebula!.uat}');
    });
  }

  void getNebulaData() {
    clientNebula
        .getAppVersion(
      currentVersionCode: 2,
      currentServiceModel: 'CPH2173',
      // currentServiceModel: '666',
      currentPackageName: 'ai.nreal.nebula.universal',
      operatorCode: null,
      operatorCountryCode: null,
    )
        .then((HttpNebulaResult result) {
      Log.e('RetrofitDemoLogic.getVersion_${result.toString()}');
      final AppUpdateInfo appUpdateInfo = AppUpdateInfo.fromJson(result.data);

      Log.e(
          'RetrofitDemoLogic.getVersion_isUpgrade= ${appUpdateInfo.isUpgrade}');
      Log.e(
          'RetrofitDemoLogic.getVersion_level ${appUpdateInfo.blacklistInfo!.level}');
      Log.e(
          'RetrofitDemoLogic.getVersion_versionCode= ${appUpdateInfo.latestVersion!.versionCode ?? 0}');
      Log.e(
          'RetrofitDemoLogic.getVersion_serviceVersionCode= ${appUpdateInfo.latestServicePackage!.versionCode ?? 0}');
    });
  }
}

const String auth_head =
    'bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRfaWQiOiIwMDAwMDAiLCJ1c2VyX25hbWUiOiJhZG1pbiIsImlzcyI6Imh0dHBzOi8vd3d3Lm5yZWFsLmFpIiwicmVhbF9uYW1lIjoi566h55CG5ZGYIiwiYXZhdGFyIjoiIiwiYXV0aG9yaXRpZXMiOlsiYWRtaW5pc3RyYXRvciJdLCJjbGllbnRfaWQiOiJwaW5lIiwicm9sZV9uYW1lIjoiYWRtaW5pc3RyYXRvciIsImxpY2Vuc2UiOiJOcmVhbCBUZWNob25vbG9neSBMaW1pdGVkIiwicG9zdF9pZCI6IjExMjM1OTg4MTc3Mzg2NzUyMDEiLCJ1c2VyX2lkIjoiYWRtaW58MTEyMzU5ODgyMTczODY3NTIwMSIsInJvbGVfaWQiOiIxMTIzNTk4ODE2NzM4Njc1MjAxIiwic2NvcGUiOlsiYWxsIl0sIm5pY2tfbmFtZSI6IueuoeeQhuWRmCIsIm9hdXRoX2lkIjoiIiwiZGV0YWlsIjp7InR5cGUiOiJ3ZWIifSwiZXhwIjoxNjM0MTk1NjgzLCJkZXB0X2lkIjoiMTEyMzU5ODgxMzczODY3NTIwMSIsImp0aSI6IjU1OGU0N2I3LTExMWMtNDJmOS04MDJhLWM1NTczYjEyYjE4OSIsImFjY291bnQiOiJhZG1pbiJ9.lbTl2uAiAjNOWhZGmJlYN6Eh4TaqUL6bg9rF-OiZiynWbqG0lqskKDmbpueUvYhg7z2j9kUYUYvfhWi0GyaHBpNcyYOF98sWBiNMd_qAxVLiVLncA3dmZHv-pXi2X0lH2wyUaPBhzX2hME6nlt5wVGd5iLvzMZ_vIimKQFymNsBdHDbMyLNi7Jqaxh6ONtnBVsiX2Jb5ShWFuafIN8LGIXEiikmWUqXzbRO4QWVR6cbdn2SRxBfxNi8jbvpPh87VvZy6pcfWiUe2_Un0JVWHNhjztDG_FXukcH6oxYm0dmasesGBIIvQgaBCx6C2F4hX6xeXk9hqf39bJnT9pM_pqg';
