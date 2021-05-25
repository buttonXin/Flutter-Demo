import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/nebula/view/base_view.dart';

import 'new_view_util.dart';

// ignore: must_be_immutable
class BaseCommonPageView extends StatefulWidget {
  String childBackText;
  String childTopTitleText;

  // 是否需要头像，默认false 不需要
  bool isUserAvatar;

  // 头部的icon
  String userChildTopIcon;

  // 头像点击事件
  Function userChildTopIconOnTap;
  Widget childCenter;
  Widget bottomChild;

  // 最下面的bottom需要占据剩余的全部空间吗？ 默认false 不占据.
  bool bottomExpanded;

  // 是否需要底部view的padding， 默认true，需要自动添加。
  bool needBottomPadding;

  // ignore: sort_constructors_first
  BaseCommonPageView({
    @required this.childCenter,
    this.childBackText= 'title',
    this.childTopTitleText,
    this.userChildTopIcon = '',
    this.userChildTopIconOnTap,
    this.isUserAvatar = false,
    this.bottomChild,
    this.bottomExpanded = false,
    this.needBottomPadding = true,
  });

  @override
  _BaseCommonPageViewState createState() => _BaseCommonPageViewState();
}

class _BaseCommonPageViewState extends State<BaseCommonPageView> {
  final double _leftSize = 40;
  final double _topSize = 43;
  final double _rightSize = 40;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: MyAppBar(childBackText: widget.childBackText,childTopTitleText: widget.childTopTitleText,),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SafeArea(
            top: true,
            child: _buildTopBackView(),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 中间的显示层
              Container(
                alignment: Alignment.centerLeft,
                child: widget.childCenter,
              ),

              // // 需要根据bottomExpanded来动态显示
              // widget.bottomExpanded ? const SizedBox() : const Spacer(),
              // // 最下的显示层
              // _buildBottomView(),
            ],
          ),
        ),
      ),
    );
  }

  /// 顶层的文案， 只有左上右 ， 下的边距交给最外层的view来加
  Widget _buildTopTitle() {
    if (widget.childTopTitleText == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(
          left: _leftSize, top: _topSize, right: _rightSize, bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.childTopTitleText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          _buildUserAvatarView()
        ],
      ),
    );
  }

  Widget _buildTopBackView() {
    if (widget.childBackText == null) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      child: TitleBackView(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.red,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Icon(Icons.arrow_back_outlined),
              ),
              Text(
                widget.childBackText,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .apply(color: Colors.black)
                    .apply(fontWeightDelta: 3),
//                  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomView() {
    if (widget.bottomExpanded) {
      return Expanded(
        child: Padding(
          padding: widget.needBottomPadding
              ? NewViewUtil.paddingGlobal()
              : EdgeInsets.zero,
          child: Container(
            alignment: Alignment.center,
            child: widget.bottomChild ?? Container(),
          ),
        ),
      );
    }

    return Padding(
      padding: NewViewUtil.paddingGlobal(),
      child: Container(
        alignment: Alignment.center,
        child: widget.bottomChild ?? Container(),
      ),
    );
  }

  Widget _buildUserAvatarView() {
    if (!widget.isUserAvatar) {
      return Container();
    }
    // 未登录
    if (widget.userChildTopIcon == null) {
      return GestureDetector(
        onTap: widget.userChildTopIconOnTap,
        child: const CircleAvatar(
          backgroundImage: AssetImage('resource/images/user_default.png'),
          radius: 25,
        ),
      );
    }

    return GestureDetector(
      onTap: widget.userChildTopIconOnTap,
      child: CachedNetworkImage(
          imageUrl: widget.userChildTopIcon ?? '',
          placeholder: (BuildContext context, String str) {
            return const CircleAvatar(
              backgroundImage: AssetImage('resource/images/user_default.png'),
              radius: 25,
            );
          },
          errorWidget: (BuildContext context, String url, _) {
            return const CircleAvatar(
              backgroundImage: AssetImage('resource/images/user_default.png'),
              radius: 25,
            );
          },
          imageBuilder: (BuildContext context, ImageProvider imageProvider) {
            return CircleAvatar(
              backgroundImage: imageProvider,
              radius: 25,
            );
          }),
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  String childBackText;
  String childTopTitleText;

  MyAppBar({this.childBackText, this.childTopTitleText});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return _buildTopWidget();
  }

  Widget _buildTopWidget() {
    if (widget.childTopTitleText == null) {
      // 最上层是否需要返回的按钮
      return _buildTopBackView();
    }

    if (widget.childBackText == null) {
      // 顶层的Title
      return _buildTopTitle();
    }
    return Container();
  }

  /// 顶层的文案， 只有左上右 ， 下的边距交给最外层的view来加
  Widget _buildTopTitle() {
    if (widget.childTopTitleText == null) {
      return Container();
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Padding(
        padding: EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.childTopTitleText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            // _buildUserAvatarView()
          ],
        ),
      ),
    );
  }

  Widget _buildTopBackView() {
    if (widget.childBackText == null) {
      return Container();
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      child: TitleBackView(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Icon(Icons.arrow_back_outlined),
              ),
              Text(
                widget.childBackText,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .apply(color: Colors.white)
                    .apply(fontWeightDelta: 3),
//                  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
