import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RetrofitDemoPage extends StatelessWidget {
  final RetrofitDemoLogic logic = Get.put(RetrofitDemoLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [

        ElevatedButton(onPressed: (){
          logic.getInitData();

        },child: const Text('测试retrofit的base'),)

      ],),
    );
  }
}
