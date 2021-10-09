import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 自定义switch控件
@immutable
class CustomSwitchTitle extends StatefulWidget {
  CustomSwitchTitle(
      {this.title,
      this.value,
      this.onChanged,
      this.activeColor,
      this.trackColor,
      this.onTap,
      this.padding = const EdgeInsets.symmetric(horizontal: 5),
      this.showIcon = false});

  String? title;
  bool? value;
  ValueChanged<bool>? onChanged;
  Color? activeColor;
  Color? trackColor;

  // 是否显示问号
  bool showIcon;

  Function? onTap;
  EdgeInsetsGeometry padding;

  @override
  _CustomSwitchTitleState createState() => _CustomSwitchTitleState();
}

class _CustomSwitchTitleState extends State<CustomSwitchTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(text: widget.title),
              WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: widget.showIcon
                        ? GestureDetector(
                            onTap: widget.onTap as void Function()?,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(Icons.help),
                            ))
                        : Container(),
                  ),
                  alignment: ui.PlaceholderAlignment.middle)
            ],
          ),
        )),
        Padding(
          padding: widget.padding,
          child: CupertinoSwitch(
            value: widget.value!,
            onChanged: widget.onChanged,
            activeColor: widget.activeColor ?? CupertinoColors.activeGreen,
            trackColor: widget.trackColor ?? CupertinoColors.inactiveGray,
          ),
        ),
      ],
    );
  }
}
