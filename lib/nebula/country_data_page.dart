import 'package:flutter/material.dart';

import 'account/login_out_plugin.dart';

class CountryDataPage extends StatefulWidget {
  @override
  _CountryDataPageState createState() => _CountryDataPageState();
}

class _CountryDataPageState extends State<CountryDataPage> {
  final Map<int, String> _map = {
    1: 'EU',
    2: 'JP',
    3: 'KO',
    4: 'US',
  };
  int? groupIndex;

  String? countryData;

  @override
  void initState() {
    super.initState();
    groupIndex = 1;
    countryData = _map[groupIndex!];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '请选择数据存储到哪一个国家',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          _RadioButtonWidget(),
          const SizedBox(height: 40),
          RaisedButton(
            onPressed: _Login,
            child: const Text('Login in '),
          ),
          RaisedButton(
            onPressed: _Logout,
            child: const Text('Login out'),
          ),

          RaisedButton(
            onPressed: _updateUserInfo,
            child: const Text('update user data'),
          ),
        ],
      ),
    );
  }

  Widget _RadioButtonWidget() {
    return Column(
      children: [
        RadioListTile<int>(
          title: Text(_map[1]!),
          value: 1,
          groupValue: groupIndex,
          onChanged: (int? e) => updateGroupValue(e),
        ),
        RadioListTile<int>(
          title: Text(_map[2]!),
          value: 2,
          groupValue: groupIndex,
          onChanged: (int? e) => updateGroupValue(e),
        ),
        RadioListTile<int>(
          title: Text(_map[3]!),
          value: 3,
          groupValue: groupIndex,
          onChanged: (int? e) => updateGroupValue(e),
        ),
        RadioListTile<int>(
          title: Text(_map[4]!),
          value: 4,
          groupValue: groupIndex,
          onChanged: (int? e) => updateGroupValue(e),
        ),
      ],
    );
  }

  ///更新group的值,Radio的value==groupValue时候,则按钮选中
  void updateGroupValue(int? e) {
    print('lao_gao-->_RadioButtonState_updateGroupValue_${_map[e!]}');
    setState(() {
      groupIndex = e;
    });
  }

  void _Login() {
    LoginOutPlugin().login(countryData);
  }
  void _Logout() {
    LoginOutPlugin().logout();
  }

  void _updateUserInfo() {
    LoginOutPlugin().updateUserInfo();
  }
}
