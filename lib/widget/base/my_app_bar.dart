import 'package:flutter/material.dart';

/// 这是一个可以指定SafeArea区域背景色的AppBar
/// PreferredSizeWidget提供指定高度的方法
/// 如果没有约束其高度，则会使用PreferredSizeWidget指定的高度

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  Color navigationBarBackgroundColor; //设置导航栏背景的颜色
  Widget leadingWidget;
  Widget trailingWidget;
  String title;
  CustomAppbar({
    @required this.leadingWidget,
    @required this.title,
    this.contentHeight = 44,
    this.navigationBarBackgroundColor = Colors.white,
    this.trailingWidget,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return _CustomAppbarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}

/// 这里没有直接用SafeArea，而是用Container包装了一层
/// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
/// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.navigationBarBackgroundColor,
      child:  SafeArea(
        top: true,
        child:  Container(
            // const BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter))
            // decoration:  const UnderlineTabIndicator(
            //   borderSide: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
            // ),
            decoration:  const UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: Color(0xFF121212)),
            ),
            height: widget.contentHeight,
            child:  Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  child:  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: widget.leadingWidget,
                  ),
                ),
                 Container(
                  child:  Text(widget.title,
                      style:  TextStyle(
                          fontSize: 17, color: Color(0xFF333333))),
                ),
                Positioned(
                  right: 0,
                  child:  Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: widget.trailingWidget,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
