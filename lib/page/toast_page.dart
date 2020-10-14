import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ToastPage extends StatefulWidget {
  @override
  _ToastPageState createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  @override
  Widget build(BuildContext context) {

    DefaultAssetBundle.of(context).loadString("images/data/lgu.json").then((value){

      List<Map<String,dynamic>> map = json.decode(value);
      print('lao_gao-->_ToastPageState_build_$map    ${map[0]}');
    });

    return Scaffold(
      body: Container(
        child: Center(
          child: FloatingActionButton(
            onPressed: () async {
              Toast.show(context: context, message: 'sdasdasqwrfadfasdfsa');

              String httpUrl = 'https://play.google.com/store/apps/details?id=ai.nreal.neubla';
              String phoneUrl = 'tel:18039125095';
              String smsUrl = 'sms:18039125095';
              String emailUrl = 'mailto:after_sales_kr@nreal.ai';
              if (await canLaunch(smsUrl)) {
                await launch(smsUrl);
              } else {
                print('lao_gao-->_ToastPageState_build_xxxxxx}');
              }
            },
            child: Text("asdasd"),
          ),
        ),
      ),
    );
  }
}
