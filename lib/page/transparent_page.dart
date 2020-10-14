import 'package:flutter/material.dart';

class TransparentPage extends StatefulWidget {
  @override
  _TransparentPageState createState() => _TransparentPageState();
}

class _TransparentPageState extends State<TransparentPage> {
  @override
  Widget build(BuildContext context) {

    showDialog(context: context,builder: (_){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Center(
              child: Text(
                '12345678',
                style: TextStyle(fontSize: 30 , color: Colors.red),
              ),
            )),
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Center(
        child: Text(
          '12345678',
          style: TextStyle(fontSize: 30 , color: Colors.red),
        ),
      )),
    );
  }
}
