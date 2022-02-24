import 'package:flutter/material.dart';

class CommonView {
  /// 通过按钮，根据不同的参数来显示不同的效果
  static Widget createButton(
    String text,
    VoidCallback onClick, {
    double height = 50,
    // 宽度默认true，组件铺满宽度
    bool widthMax = true,
    EdgeInsetsGeometry? margin,
    // 是否需要按钮渐变,默认false 不需要
    bool isGradient = false,
  }) {
    // 根据是否有渐变色，来判断按钮的总体颜色
    final Color allColor =
        isGradient ? Colors.transparent : const Color(0xffFCB605);

    margin ??= const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 5,
    );
    // 按钮配置
    final Widget child = ElevatedButton(
      onPressed: onClick,
      child: Text(text),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.all(allColor),
        shadowColor: MaterialStateProperty.all(allColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );

    if (widthMax) {
      return Container(
        width: double.infinity,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            // todo  修改颜色
            // 渐变色
            gradient: const LinearGradient(colors: [Colors.blue, Colors.red]),
            // 这里与下面的shape要对应
            borderRadius: BorderRadius.circular(10)),
        child: child,
      );
    } else {
      return Container(
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            // todo  修改颜色
            // 渐变色
            gradient: const LinearGradient(colors: [Colors.blue, Colors.red]),
            // 这里与下面的shape要对应
            borderRadius: BorderRadius.circular(10)),
        child: child,
      );
    }

    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          // todo  修改颜色
          // 渐变色
          gradient: const LinearGradient(colors: [Colors.blue, Colors.red]),
          // 这里与下面的shape要对应
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(text),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(2),
          backgroundColor: MaterialStateProperty.all(allColor),
          shadowColor: MaterialStateProperty.all(allColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }

  static Widget createTextField({
    TextEditingController? textEditingController,
    double height = 50,
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 5,
    ),
  }) {
    return Container(
      width: double.infinity,
      // height: 200,
      margin: margin,
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
        // 边色与边宽度
// 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
        boxShadow: [
          BoxShadow(
              color: Color(0x99FFFF00),
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0),
          BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)),
          BoxShadow(color: Color(0xFF0000FF))
        ],
      ),
      //   child: ConstrainedBox(
      //   constraints: BoxConstraints(
      //     maxHeight: 100,
      //     minHeight: 30,
      //
      //
      //   ),
      child: TextField(
        controller: textEditingController,
        maxLines: 1,
        // inputFormatters: [LengthLimitingTextInputFormatter(254)],
        scrollPadding: EdgeInsets.zero,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(
              color: Colors.red, fontSize: 15, fontWeight: FontWeight.normal),
          hintMaxLines: 1,
          // contentPadding: const EdgeInsets.all(1),
          // prefixIcon: Icon(Icons.add),
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          fillColor: Colors.grey,
          //背景颜色，必须结合filled: true,才有效
          filled: true,
          //重点，必须设置为true，fillColor才有效
          prefixIcon: Icon(Icons.add),
          // isCollapsed: true,//重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
        ),
        // ),
      ),
    );
  }

  static BoxDecoration buildRoundDe() {
    return const BoxDecoration(
        color: Colors.grey,
        boxShadow: newBoxShadow,
        // gradient: newButtonGradient,
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }

  static const LinearGradient newButtonGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Color(0xFF9571D0), Color(0xFF674B94)]);

  static const List<BoxShadow> newBoxShadow = [
    // BoxShadow(color: Color(0x0017092E), offset: Offset(0, 1)),
    BoxShadow(
        color: Colors.grey,
        // offset: Offset(0,-1),
        blurRadius: 5,
        spreadRadius: 0),
  ];
}
