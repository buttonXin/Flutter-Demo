import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/base/shadow_background.dart';

class NewViewUtil {
  static Widget buildSectionTitle(BuildContext context, String text,
      {double bottomPadding = 20}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        '$text',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  static Widget buildInfo(String text, {TextStyle? textStyle}) {
    return Text(
      '$text',
      style: textStyle,
      maxLines: 2,
    );
  }

  static Widget buildColorDivider({Color? color, double verticalSize = 1.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalSize),
      child: Divider(
        color: color,
      ),
    );
  }

  /// 构建一个全局的padding， 统一宽度
  static Widget buildGlobalPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: child,
    );
  }

  /// 全局的ListTitle 布局， 保证宽高箭头一致
  /// 下面的 宽高要有默认值！！！
  static Widget buildGlobalListTitle({
    required Text text,
    double vertical = 25,
    double horizontal = 20,
    Function? onTap,
  }) {
    return ShadowBgView(
      text: text,
      vertical: vertical,
      horizontal: horizontal,
      onTap: onTap,
    );
  }

  /// 全局的 InkWell 布局， 保证点击效果一致
  static Widget buildGlobalInkWell({required Widget child, Function? onTap}) {
    return InkWell(
//      splashColor: Colors.transparent,
      highlightColor: Colors.grey,
      child: child,
      onTap: onTap as void Function()?,
    );
  }

  static EdgeInsets paddingGlobal(
      {EdgeInsets paddingGlobal = const EdgeInsets.only(left: 40, right: 40)}) {
    return paddingGlobal;
  }
}
