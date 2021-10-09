import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({ Key? key}) : super(key: key);

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);

  /// 前后台切换
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {}
    super.didChangeAppLifecycleState(state);
  }
}
