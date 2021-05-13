import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_github_demo/base_view_page/base_page.dart';
import 'package:flutter_github_demo/widget/base/base_common_page_view.dart';

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

  @override
  Widget buildWidget(BuildContext context) {
    return BaseCommonPageView(childCenter: Text('222222'));
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
