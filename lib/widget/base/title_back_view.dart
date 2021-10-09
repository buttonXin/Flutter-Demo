import 'package:flutter/material.dart';

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
      onTap: widget.onTap as void Function()?,
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
