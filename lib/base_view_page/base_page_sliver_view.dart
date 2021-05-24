import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/nebula/view/base_view.dart';
import 'package:flutter_github_demo/widget/base/new_view_util.dart';

// ignore: must_be_immutable
class BasePageSliver extends StatefulWidget {
  String childBackText;

  // 是否需要返回键,默认true 需要。
  bool hasBackIcon;

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
  BasePageSliver({
    @required this.childCenter,
    this.childBackText,
    this.userChildTopIcon,
    this.userChildTopIconOnTap,
    this.hasBackIcon = true,
    this.bottomChild,
    this.bottomExpanded = false,
    this.needBottomPadding = true,
  });

  @override
  _BasePageSliverState createState() => _BasePageSliverState();
}

class _BasePageSliverState extends State<BasePageSliver> {
  final Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: CustomScrollView(
            slivers: <Widget>[
              // _buildBanner(),
              _buildStickyBar(),
              _buildList(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: widget.bottomChild,
      ),
    );
  }

  Widget _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 120, //收起的高度
          maxHeight: 120, //展开的最大高度

          child: _buildTopBackView()),
    );
  }

  Widget _buildTopBackView() {
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: TitleBackView(
        onTap: widget.hasBackIcon
            ? () {
                Navigator.pop(context);
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Row(
            children: [
              if (widget.hasBackIcon)
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  // child: const ImageIcon(
                  //   AssetImage('resource/images/back.png'),
                  //   size: 20.0,
                  // ),

                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: _color,
                  ),
                )
              else
                Container(),
              Text(
                widget.childBackText,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: _color),
//                  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold)
              ),
              if (widget.userChildTopIcon == null)
                Container()
              else
                _buildUserAvatarView()
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

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return widget.childCenter;
      },
      childCount: 1,
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
