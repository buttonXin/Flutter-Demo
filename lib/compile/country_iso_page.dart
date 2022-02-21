import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_github_demo/base_view_page/base_page.dart';
import 'package:flutter_github_demo/widget/base/base_common_page_view.dart';
import 'dart:ui' as ui;

import 'package:flutter_github_demo/widget/custom_switch_title.dart';
import 'package:get/get.dart';

import 'retrofit_demo/logic.dart';

class CountryIsoPage extends BasePage {
  @override
  BasePageState<BasePage> getState() {
    return _CountryIsoPageState();
  }
}

class _CountryIsoPageState extends BasePageState<CountryIsoPage> {
  @override
  void initState() {
    initCountry();
    super.initState();
  }

  bool _testSwitch = false;

  bool showIcon = true;

  String name = '';

  final RetrofitDemoLogic logic = Get.find<RetrofitDemoLogic>();

  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('222222'),
            CustomSwitchTitle(
              title: 'dasdasdasdasdasd$name',
              value: _testSwitch,
              onChanged: (bool v) {
                setState(() {
                  _testSwitch = v;
                });
              },
              showIcon: true,
              onTap: () {
                logic.getInitData();
                setState(() {
                  name = '$name-click-name';
                });
              },
            ),
          ],
        ),
      )),
    );
  }

  Future<void> initCountry() async {
    // 这2个是变量
    const String localLanguage = 'zh';
    const String countryISOCode = 'ES';

    await CountryCodes.init(const Locale(localLanguage, 'US'));

    final CountryDetails details =
        CountryCodes.detailsForLocale(const Locale('en', countryISOCode));
    // 对应的ISO的号。
    print(details.alpha2Code);

    // localLanguage语言对应的国家名字。
    print(details.localizedName);
  }
}
