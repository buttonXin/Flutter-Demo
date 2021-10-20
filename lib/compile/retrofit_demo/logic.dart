import 'package:flutter_github_demo/model/base_model.dart';
import 'package:flutter_github_demo/model/nebula_base_model.dart';
import 'package:flutter_github_demo/util/L.dart';
import 'package:get/get.dart';

class RetrofitDemoLogic extends GetxController {
  final RestClient client = Get.find<RestClient>();
  final NebulaRestClient clientNebula = Get.find<NebulaRestClient>();

  void getInitData() {
    client.getInitData().then((HttpResult httpResult) {
      L.e(httpResult.toString());

      final InitDataBean infoData = InitDataBean.fromJson(httpResult.data);

      L.e(infoData.versionInfo!.nebula![0].nebulaName);

      L.e('ok');
    });

    L.e('line');
    client.getAppListData().then((HttpResult httpResult) {
      final Map<String, dynamic> data = httpResult.data;

      L.e(data['app_list']);
      L.e('ok');
    });

    client
        .getAppListForPathData(
        'https://nreal-public.nreal.ai/android/nebula/app_data_DT.json')
        .then((HttpResult httpResult) {
      final Map<String, dynamic> data = httpResult.data;
      L.e('url-->');
      final data2 = data['app_list'];
      L.e('url---> $data2');
      L.e('ok');
    });
  }

  void getVersion() {
    clientNebula.getAppVersion(
        '10', 'currentServiceModel', 'hardwareCode', 'operatorCode',
        'operatorCountryCode', 'versionCode',
        auth_head
    ).then((HttpNebulaResult result) {

          L.e('RetrofitDemoLogic.getVersion_${result.toString()}');

    });
  }
}



const String auth_head = 'bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnRfaWQiOiIwMDAwMDAiLCJ1c2VyX25hbWUiOiJhZG1pbiIsImlzcyI6Imh0dHBzOi8vd3d3Lm5yZWFsLmFpIiwicmVhbF9uYW1lIjoi566h55CG5ZGYIiwiYXZhdGFyIjoiIiwiYXV0aG9yaXRpZXMiOlsiYWRtaW5pc3RyYXRvciJdLCJjbGllbnRfaWQiOiJwaW5lIiwicm9sZV9uYW1lIjoiYWRtaW5pc3RyYXRvciIsImxpY2Vuc2UiOiJOcmVhbCBUZWNob25vbG9neSBMaW1pdGVkIiwicG9zdF9pZCI6IjExMjM1OTg4MTc3Mzg2NzUyMDEiLCJ1c2VyX2lkIjoiYWRtaW58MTEyMzU5ODgyMTczODY3NTIwMSIsInJvbGVfaWQiOiIxMTIzNTk4ODE2NzM4Njc1MjAxIiwic2NvcGUiOlsiYWxsIl0sIm5pY2tfbmFtZSI6IueuoeeQhuWRmCIsIm9hdXRoX2lkIjoiIiwiZGV0YWlsIjp7InR5cGUiOiJ3ZWIifSwiZXhwIjoxNjM0MTk1NjgzLCJkZXB0X2lkIjoiMTEyMzU5ODgxMzczODY3NTIwMSIsImp0aSI6IjU1OGU0N2I3LTExMWMtNDJmOS04MDJhLWM1NTczYjEyYjE4OSIsImFjY291bnQiOiJhZG1pbiJ9.lbTl2uAiAjNOWhZGmJlYN6Eh4TaqUL6bg9rF-OiZiynWbqG0lqskKDmbpueUvYhg7z2j9kUYUYvfhWi0GyaHBpNcyYOF98sWBiNMd_qAxVLiVLncA3dmZHv-pXi2X0lH2wyUaPBhzX2hME6nlt5wVGd5iLvzMZ_vIimKQFymNsBdHDbMyLNi7Jqaxh6ONtnBVsiX2Jb5ShWFuafIN8LGIXEiikmWUqXzbRO4QWVR6cbdn2SRxBfxNi8jbvpPh87VvZy6pcfWiUe2_Un0JVWHNhjztDG_FXukcH6oxYm0dmasesGBIIvQgaBCx6C2F4hX6xeXk9hqf39bJnT9pM_pqg';
