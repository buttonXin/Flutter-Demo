import 'package:flutter/material.dart';

// 圆形的checkBox
class RoundCheckBox extends StatefulWidget {
  var value = false;

  Function(bool)? onChanged;
  Color unSelectorColor;
  bool canSelector;

  RoundCheckBox(
      {Key? key,
      required this.value,
      this.onChanged,
      this.unSelectorColor = Colors.red,
      this.canSelector = true})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            if (widget.canSelector) {
              widget.value = !widget.value;
              widget.onChanged!(widget.value);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:

            widget.value
                ? Icon(
              Icons.check_circle,
                    size: 25.0,
                    color: Colors.red,
                  )
                : widget.canSelector? Icon(
                    Icons.panorama_fish_eye,
                    size: 25.0,
                    color: widget.unSelectorColor,
                  ):
            Icon(
              Icons.check,
              size: 25.0,
              color: Colors.red,
            ),
          )),
    );
  }
}
