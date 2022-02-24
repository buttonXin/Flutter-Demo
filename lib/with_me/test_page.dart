import 'package:flutter/material.dart';
import 'package:flutter_github_demo/util/L.dart';
import 'package:flutter_github_demo/widget/toast.dart';
import 'package:flutter_github_demo/with_me/widget/common_title_view.dart';
import 'package:flutter_github_demo/with_me/widget/common_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController textController = TextEditingController();

  //输入框控制器，一般用于获取文本、修改文本等
  TextEditingController _inputController = TextEditingController();

//焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  FocusNode _inputFocusNode = FocusNode();

//边框样式
  OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        // mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 90,
          ),
          CommonView.createButton('通用按钮1', () {
            Log.e('000000');
          }, widthMax: false),
          CommonView.createButton('通用按钮2', () {
            Log.e('11111');
          }, isGradient: true),
          // CommonView.createTextField(
          //   textEditingController: textController,
          // ),
          CommonView.createTextField(
            textEditingController: textController,
          ),

          // Container(
          //   height: 50,
          //   margin: EdgeInsets.all(20),
          //   decoration: CommonView.buildRoundDe(),
          //   child: TextField(
          //     controller: _inputController,
          //     //控制器
          //     focusNode: _inputFocusNode,
          //     //焦点
          //     style: TextStyle(fontSize: 16, color: Colors.black87),
          //     //文字大小、颜色
          //     maxLines: null,
          //     //最多多少行
          //     minLines: 1,
          //     //最少多少行
          //     onChanged: (text) {
          //       //输入框内容变化回调
          //       setState(() {});
          //     },
          //     decoration: InputDecoration(
          //       fillColor: Colors.grey,
          //       //背景颜色，必须结合filled: true,才有效
          //       filled: true,
          //       //重点，必须设置为true，fillColor才有效
          //       isCollapsed: true,
          //       //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
          //       contentPadding:
          //           EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          //       //内容内边距，影响高度
          //       border: _outlineInputBorder,
          //       //边框，一般下面的几个边框一起设置
          //       //keyboardType: TextInputType.number, //键盘类型
          //       //obscureText: true,//密码模式
          //       focusedBorder: _outlineInputBorder,
          //       enabledBorder: _outlineInputBorder,
          //       disabledBorder: _outlineInputBorder,
          //       focusedErrorBorder: _outlineInputBorder,
          //       errorBorder: _outlineInputBorder,
          //     ),
          //   ),
          //
          //   // Expanded(child: Container()),
          // ),

          CommonTitleView('centerText'),
          CommonTitleView(
            'centerText',
            backText: '返回',
            backClick: () {
              Toast().show(context, message: 'message');
            },
          ),
          CommonTitleView(
            'centerText',
            backClick: () {
              Toast().show(context, message: 'message');
            },
           
          ),
          CommonTitleView(
            'centerText',
            backClick: () {
              Toast().show(context, message: 'message');
            },
            rightButtonText: '下一步',
            rightButtonClick: () {
              Toast().show(context, message: 'rightButtonClick');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommonButton(
    String text,
    VoidCallback onClick, {
    double height = 50,
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 5,
    ),
  }) {
    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(text),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(const Color(0xffFCB605)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
