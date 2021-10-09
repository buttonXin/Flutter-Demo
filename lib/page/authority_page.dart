import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthorityPage extends StatefulWidget {
  @override
  _AuthorityPageState createState() => _AuthorityPageState();
}

class _AuthorityPageState extends State<AuthorityPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            applyPermission([
              Permission.storage,
              Permission.locationWhenInUse,
              Permission.camera,
            ]);
          },
          child: Text("点击申请权限"),
        ),
      ),
    );
  }

  List<Permission> listPermanentlyDenied = [];

  //动态申请权限
  Future applyPermission(List<Permission> listPermission) async {
    Map<Permission, PermissionStatus> statuses = await listPermission.request();
    print('lao_gao--> statuses[Permission.storage] = $statuses');

    List<Permission> tempPermission = [];
    statuses.forEach((permission, status) {
      if (status.isGranted) {
        print('lao_gao--> Granted 已经授权');
      } else if (status.isPermanentlyDenied) {
        print('lao_gao-->isPermanentlyDenied 需要跳转到setting ');
        listPermanentlyDenied.add(permission);
      } else {
        print('lao_gao-->没有授权 ');
        tempPermission.add(permission);
      }
    });
    print('lao_gao-->  未被申请的权限：$tempPermission');

    listPermission.clear();

    if (tempPermission.length == 0) {
      if (listPermanentlyDenied.length == 0) {
        return;
      }

      showDialog(
          context: context,
          builder: (_) {
            return SimpleDialog(
              title: Text("还有权限未申请，需要跳转到setting全部申请才能使用"),
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    isOpenSetting = true;
                    openAppSettings();
                  },
                  child: Text('去申请'),
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return SimpleDialog(
              title: Text("还有权限未申请，需要全部申请才能使用"),
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                    applyPermission(tempPermission);
                  },
                  child: Text('去申请'),
                ),
              ],
            );
          });
    }
  }

  bool isOpenSetting = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('lao_gao-->authority_page resumed}');
        if (isOpenSetting) {
          isOpenSetting = false;
          listPermanentlyDenied.clear();
          applyPermission([
            Permission.storage,
            Permission.locationWhenInUse,
            Permission.camera,
          ]);
        }

        break;
      case AppLifecycleState.paused:
        print('lao_gao-->authority_page.dart paused}');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    print('lao_gao--> initState');
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    print('lao_gao--> dispose}');
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
