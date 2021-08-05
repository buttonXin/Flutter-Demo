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
                // ButtonTheme 的alignedDropdown属性让CustomDropdownButton下拉出现的宽度与外面的一致。
                ButtonTheme(
                  alignedDropdown: true,
                  child: CustomDropdownButton(
                    width: 130,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    dropdownHeight: 10,
                    underline: Container(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconClick: const Icon(Icons.keyboard_arrow_up),
                    onChanged: (String newValue) {
                      setState(() {
                        _selectSleepTime = newValue;
                      });
                    },
                    value: _selectSleepTime,
                    items: items.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: DropdownButton<String>(
                  value:  _selectSleepTime,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectSleepTime = newValue;
                    });
                  },
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: TextStyle(color: _selectSleepTime == value?Colors.red:Colors.black ),),
                );
              }).toList()),
            ),
          ],
        ));
  }

  Widget _buildRow(String text, Widget child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), child],
    );
  }
}
