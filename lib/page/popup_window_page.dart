import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/custom_dropdown_button.dart';

class PopupWindowPage extends StatefulWidget {
  @override
  _PopupWindowPageState createState() => _PopupWindowPageState();
}

class _PopupWindowPageState extends State<PopupWindowPage> {
  List items = <String>[
    '1s',
    '60s',
    '120s',
    '6s',
    '80s',
    'never',
  ];

  String _selectSleepTime = '1s';
  bool _selectClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _buildRow(
                'PopupWindow',
                PopupMenuButton(
                  itemBuilder: (_) {
                    return items
                        .map((item) => PopupMenuItem<String>(
                              child: Text(item),
                              value: item,
                            ))
                        .toList();
                  },
//                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(_selectSleepTime),
                        Icon(_selectClick
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up),
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    print('lao_gao-->_PopupWindowPageState_build_${value}');
                  },
                  onCanceled: () {},
                  offset: Offset(600, 600),
                )),

            // 自定义的
            _buildRow(
                'my_dropdown_button',
                CustomDropdownButton(
                  underline: Container(),
                  onChanged: (String newValue) {
                    setState(() {
                      _selectSleepTime = newValue;
                    });
                  },
                  icon: Icon(_selectClick
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up),
                  value: _selectSleepTime,
                  items: items.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ],
        ));
  }

  Widget _buildRow(String text, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), child],
    );
  }
}
