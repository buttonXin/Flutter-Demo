import 'package:flutter_github_demo/model/base_model.dart';
import 'package:flutter_github_demo/util/L.dart';
import 'package:get/get.dart';

class RetrofitDemoLogic extends GetxController {
  final RestClient client = Get.find<RestClient>();

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
  }
}
