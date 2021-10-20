import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FloatingActionButton(
            onPressed: () async {

              String httpUrl = 'https://play.google.com/store/apps/details?id=ai.nreal.neubla';
              String phoneUrl = 'tel:18039125095';
              String smsUrl = 'sms:18039125095';
              String emailUrl = 'mailto:user_account_support@nreal.ai';
              if (await canLaunch(httpUrl)) {
                await launch(httpUrl);
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
