import 'package:flutter/material.dart';
import 'package:flutter_github_demo/model/number_model.dart';
import 'package:flutter_github_demo/widget/base/base_common_page_view.dart';
import 'package:provider/provider.dart';

class ProviderDemo extends StatefulWidget {
  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NumberModel>(
        create: (BuildContext context) => NumberModel(),
        builder: (BuildContext context, Widget snapshot) {
          final NumberModel model = context.watch<NumberModel>();
          return BaseCommonPageView(
              childBackText: '测试Provider',
              childCenter: Column(
                children: [
                  RaisedButton(
                    onPressed: () {
                      model.addNumber();
                    },
                    child: const Text('+++'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.reduceNumber();
                    },
                    child: const Text('---'),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('${model.number}'),
                  ),
                ],
              ));
        });
  }
}
