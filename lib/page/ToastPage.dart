import 'package:flutter/material.dart';
import 'package:flutter_github_demo/widget/toast.dart';

class ToastPage extends StatefulWidget {
  @override
  _ToastPageState createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Center(child: FloatingActionButton(onPressed: (){
        Toast.show(context: context, message: "dasdasdasdasd");
      },child: Text("asdasd"),),),
    ));
  }
}
