import 'package:flutter/material.dart';
import 'package:flutter_github_demo/with_me/widget/common_widget.dart';

/// 通用的title组件
// ignore: must_be_immutable
class CommonTitleView extends StatefulWidget {
  CommonTitleView(this.centerText,
      {this.backClick,
      this.backText,
      this.rightButtonText,
      this.rightButtonClick});

  final String centerText;
  String? backText;
  Function? backClick;
  String? rightButtonText;
  Function? rightButtonClick;

  @override
  _CommonTitleViewState createState() => _CommonTitleViewState();
}

class _CommonTitleViewState extends State<CommonTitleView> {
  TextStyle backStyle = const TextStyle(fontSize: 16, color: Colors.grey);
  TextStyle centerStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // back
          if (widget.backClick == null)
            Container()
          else
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: () {
                  widget.backClick?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      // const SizedBox(width: 5),
                      Text(
                        widget.backText ?? '',
                        style: backStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // center
          Positioned(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.centerText,
                style: centerStyle,
              ),
            ),
          ),
          // right
          if (widget.rightButtonText == null)
            Container()
          else
            Positioned(
              right: 0,
              child: CommonView.createButton(widget.rightButtonText ?? '', () {
                widget.rightButtonClick?.call();
              }, widthMax: false, height: 30),
            )
        ],
      ),
    );
  }
}
