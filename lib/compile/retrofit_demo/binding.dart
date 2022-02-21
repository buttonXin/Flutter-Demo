
import 'package:get/get.dart';

import 'logic.dart';

class RetrofitDemoBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut(() => RetrofitDemoLogic());
  }
}