

import 'package:flutter/material.dart';

Widget buildTopBackView(BuildContext context) {

  return Container(
    margin: const EdgeInsets.only(top: 30, bottom: 30),
    child: TitleBackView(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const ImageIcon(
                AssetImage('resource/images/back.png'),
                size: 20.0,
                color: Colors.white,
              ),
            ),
            Text(
              '个人中心',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .apply(fontWeightDelta: 3)
              .apply(color: Colors.white),
//                  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    ),
  );
}

class TitleBackView extends StatefulWidget {
  Function? onTap;
  Widget? child;

  TitleBackView({Key? key, this.onTap, this.child});

  @override
  _TitleBackViewState createState() => _TitleBackViewState();
}

class _TitleBackViewState extends State<TitleBackView> {
  final Color _clickColor = Colors.grey.withOpacity(0.5);
  final Color _defaultColor = Colors.transparent;

  Color? _color;

  @override
  void initState() {
    super.initState();
    _color = _defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      onTapDown: (TapDownDetails details) => {
        setState(() {
          _color = _clickColor;
        }),
      },
      onTapCancel: () {
        setState(() {
          _color = _defaultColor;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _color = _defaultColor;
        });
      },
      child: Container(
          color: _color,
          child: widget.child
      ),
    );
  }
}
