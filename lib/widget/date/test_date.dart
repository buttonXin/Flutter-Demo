import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class TestDatePicker extends StatefulWidget {
  @override
  _TestDatePickerState createState() => _TestDatePickerState();
}

class _TestDatePickerState extends State<TestDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
      DatePicker.showDatePicker(context,
      initialDateTime: DateTime.now(),
          dateFormat: 'd|MM,yyyy',
        onConfirm: (DateTime date,List<int> selectedIndex){

        }
      );

            },
            child: Text(
              '2345768',
              style: const TextStyle(fontSize: 30),
            )),
      ),
    );
  }

  _change(String s) {}
}
