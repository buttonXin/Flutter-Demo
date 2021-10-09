import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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



              //  2021-03-10 00:00:00.000
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                textDirection: TextDirection.ltr

              ).then((DateTime? dateTime){
                print('dateTime = $dateTime');
              });
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
