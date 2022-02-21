

import 'package:flutter_github_demo/compile/retrofit_demo/binding.dart';
import 'package:flutter_github_demo/compile/retrofit_demo/view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

mixin AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.DevNebulaOptions,
      page: () => RetrofitDemoPage(),
      binding: RetrofitDemoBinding(),
    ),
    // GetPage(
    //   name: Routes.DevGlassesOptions,
    //   page: () => GlassesOptionsPage(),
    //   binding: GlassesOptionsBinding(),
    // ),
  ];
}
