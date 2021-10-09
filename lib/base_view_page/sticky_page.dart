import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_github_demo/nebula/view/base_view.dart';

import 'base_page_sliver_view.dart';

class StickyPage extends StatefulWidget {
  @override
  _StickyPageState createState() => _StickyPageState();
}

class _StickyPageState extends State<StickyPage> {
  Color _color = Colors.white;
  bool _showText = false;

  @override
  Widget build(BuildContext context) {
    int index = 9;
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(title: Text("标题")),
          body: BasePageSliver(
        hasBackIcon: false,
        childBackText: 'fnahuixjian',
        childCenter: Column(
          children: [
            GestureDetector(
                onTap: () {
                  _showText = !_showText;
                  setState(() {});
                },
                child: Text(
                  "我是第$index个item",
                  style: TextStyle(fontSize: 30, color: _color),
                )),
            _showText
                ? Text(
                    "我是第show我是第show我是第show我是第show我是是第show我是第show我是是第show我是第show我是是第show我是第show我是第show我是第show我是第show",
                    style: TextStyle(fontSize: 20, color: _color),
                  )
                : Container(),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Row(
              children: [
                Text(
                  "我是第$index个item",
                  style: TextStyle(fontSize: 30, color: _color),
                ),
                Expanded(
                  child: Text(
                    "我是asdasdasdasdasdasdasd",
                    style: TextStyle(fontSize: 30, color: _color),
                  ),
                ),
              ],
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            Text(
              "我是第$index个item",
              style: TextStyle(fontSize: 30, color: _color),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
        bottomChild: RaisedButton(
          onPressed: () {},
          child: Text(
            "我是第bottom",
            style: TextStyle(fontSize: 30, color: _color),
          ),
        ),
      )),
    );
  }

  Widget _buildBanner() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 200,
        child: Image.network(
          "http://image2.sina.com.cn/ent/s/j/p/2007-01-12/U1345P28T3D1407314F329DT20070112145144.jpg",
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTopBackView() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
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
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                'widget.childBackText',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
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

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Container(
          // height: 50,
          color: index % 2 == 0 ? Colors.white : Colors.black12,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "我是第$index个item",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        );
      },
      childCount: 1,
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
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
