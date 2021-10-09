import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShadowBgView extends StatefulWidget {
  final Function? onTap;
  final Text text;
  final double? vertical;

  final double? horizontal;

  // ignore: sort_constructors_first
  ShadowBgView({
    Key? key,
    this.onTap,
    required this.text,
    this.vertical,
    this.horizontal,
  }) : super(key: key);

  @override
  _ShadowBgViewState createState() => _ShadowBgViewState();
}

class _ShadowBgViewState extends State<ShadowBgView> {
  BoxDecoration? _defaultBoxDecoration;

  BoxDecoration? _clickBoxDecoration;

  BoxDecoration? _boxDecoration;

  @override
  void initState() {
    super.initState();
    _defaultBoxDecoration = BoxDecoration(
      color: Color(0xFF1B1B1B),
      // image: DecorationImage(image: AssetImage('resource/images/list_title_normal_bg.png')),
      borderRadius: BorderRadius.circular(23),
      boxShadow: [
        // 上阴影
        const BoxShadow(color: Color(0x80000000), offset: Offset(0, 1)),
        // 下阴影
        const BoxShadow(color: Color(0x1AFFFFFF), offset: Offset(0, -1)),
      ],
    );
    _clickBoxDecoration = BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(23),
      boxShadow: [
        const BoxShadow(color: Color(0x1AFFFFFF), offset: Offset(0, -1)),
      ],
    );

    _boxDecoration = _defaultBoxDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap as void Function()?,
            onTapDown: (TapDownDetails details) => {
              setState(() {
                _boxDecoration = _clickBoxDecoration;
              }),
            },
            onTapCancel: () {
              setState(() {
                _boxDecoration = _defaultBoxDecoration;
              });
            },
            onTapUp: (TapUpDetails details) {
              setState(() {
                _boxDecoration = _defaultBoxDecoration;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: widget.vertical!, horizontal: widget.horizontal!),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: _boxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.text,
                  const ImageIcon(
                    AssetImage('resource/images/forward.png'),
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
