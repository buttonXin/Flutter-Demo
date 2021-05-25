import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_demo/nebula/view/base_view.dart';
import 'package:flutter_github_demo/widget/custom_dropdown_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool _showDistance = true;

  // 出生时间
  DateTime _dateBirthTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  // 生日时间是否允许
  bool _birthAllow = true;

  String _genderValue = '60';
  List<String> list;

  @override
  void initState() {
    list = List.generate(78 - 52, (index) {
      return '${52 + index}';
    });
    print('lao_gao-->_UserInfoPageState_initState_${list.toString()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xFF121212), Color(0xFF000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // scrollDirection: Axis.vertical,
            children: [
              buildTopBackView(context),
              const SizedBox(height: 20),
              // 头像
              _buildAvatar(),
              // email
              _buildEachInfo(
                  title: 'Email',
                  content: 'ssdasdasd@asdasd.as',
                  canEdit: false),
              // name
              _buildEachInfo(
                  title: 'UserName', content: 'sabra', canEdit: false),
              // birth
              _buildEachInfo(
                  title: 'Date of Birth',
                  content:
                      '${_dateBirthTime.year}/${_dateBirthTime.month}/${_dateBirthTime.day}',
                  canIcon: true,
                  onTop: _showDateBirth),
              // birthHint
              _buildErrorWidget(visible: !_birthAllow, text: textBirthError),
              // gender
              _buildDropWidget(
                  title: 'Gender: ',
                  value: _genderValue,
                  mapData: list,
                  onChanged: _handleLanguageChanged),
              // distance
              _buildDistanceInfo(
                  title: 'Inter Pupil Distance', onTop: _buildDialogDistance),
              // _buildErrorWidget(visible: !_showDistance ,text: textDistance),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        floatingActionButton: _buildBottomButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: NoScalingAnimation(),
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: () async {
        // const String url = 'https://nreal-public.nreal.ai/android/nebula/ai_nreal_nebula_jp_xperia.apk';
        const String url =
            'https://nreal-public.nreal.ai/android/nebula/icon/11.html';
        // const String url = 'https://dl-tc.coolapkmarket.com/down/apk_file/2021/0309/aweme_douyin_and134_v1015_140902_d292_1615224769.apk?t=1615385877&sign=15e83a49756dec82c59dc3de06b293e9';
        // const String url = 'https://www.nreal.ai/page-data/nebula/page-data.json';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: CachedNetworkImage(
          imageUrl:
              'https://nreal-public.nreal.ai/android/nebula/icon/ai.nreal.nrealtower.png',
          // placeholder: (BuildContext context, String str) {
          //   return const CircleAvatar(
          //     backgroundImage: AssetImage('/images/tutorial/1.webp'),
          //     radius: 25,
          //   );
          // },
          imageBuilder: (BuildContext context, ImageProvider imageProvider) {
            return CircleAvatar(
              backgroundImage: imageProvider,
              radius: 25,
            );
          },
        ),
      ),
    );
  }

  Widget _buildEachInfo(
      {String title,
      String content,
      bool canEdit = true,
      bool canIcon = false,
      Function onTop}) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5), // 边色与边宽度
          color: canEdit ? Colors.white : Colors.grey, // 底色
          //        borderRadius:  BorderRadius.circular((20.0)), // 圆角度
          // borderRadius:
          //     BorderRadius.all(Radius.circular(20)), // 也可控件一边圆角大小
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$title : ${content ?? ""}'),
                if (canIcon)
                  const Icon(Icons.arrow_forward_ios)
                else
                  Container(),
              ],
            )),
      ),
    );
  }

  Widget _buildDistanceInfo(
      {String title, String content, bool canEdit = true, Function onTop}) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5), // 边色与边宽度
        color: canEdit ? Colors.white : Colors.grey, // 底色
      ),
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextField(
                  // controller: _phoneController,
                  maxLines: 1,
                  scrollPadding: EdgeInsets.zero,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: '$title',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      hintMaxLines: 2,
                      contentPadding: const EdgeInsets.only(right: 5),
                      isDense: true,
                      border: InputBorder.none),
                ),
              ),
              GestureDetector(
                  onTap: onTop,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.error_outline_rounded),
                  ))
            ],
          )),
    );
  }

  /// [visible] true 表示要显示；
  Widget _buildErrorWidget({bool visible, String text}) {
    if (!visible) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(text),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      // height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

      // color: Colors.red,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            setState(() {
              _showDistance = !_showDistance;
            });
          },
          child: Text("宽度占满了"),
          color: Colors.green,
          textColor: Colors.white,
        ),
      ),
    );
  }

  /// 下拉选项
  Widget _buildDropWidget(
      {@required String title,
      @required String value,
      @required List<String> mapData,
      @required Function onChanged,
      Color dropColor = Colors.grey}) {
    const Color _arrowColor = Colors.white;
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5), // 边色与边宽度
        color: Colors.white, // 底色
        //        borderRadius:  BorderRadius.circular((20.0)), // 圆角度
        // borderRadius:
        //     BorderRadius.all(Radius.circular(20)), // 也可控件一边圆角大小
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          // ButtonTheme 的alignedDropdown属性让CustomDropdownButton下拉出现的宽度与外面的一致。
          ButtonTheme(
            alignedDropdown: true,
            child: CustomDropdownButton<String>(
              width: 130,
              decoration: BoxDecoration(
                color: dropColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down, color: _arrowColor),
              iconClick: Icon(Icons.keyboard_arrow_up, color: _arrowColor),
              onChanged: onChanged,
              dropdownColor: dropColor,
              // dropdownHeight: 10,
              value: value,
              items: mapData.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              // items: mapData
              //     .map(
              //       (String item) => DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(
              //           item,
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyText1
              //               .copyWith(fontSize: 13),
              //         ),
              //       ),
              //     )
              //     .toList(),
            ),
          ),
          // 为了将 左手模式 与 休眠时间 的右边距对齐 添加的，左手模式的switch没有找到右边距的size
          const SizedBox(width: 4)
        ],
      ),
    );
  }

  void _handleLanguageChanged(String gender) {
    setState(() {
      _genderValue = gender;
    });
  }

  /// 显示瞳距的dialog
  void _buildDialogDistance() {}

  void _showDateBirth() {}
}

/// floatButton 不进行动画
class NoScalingAnimation extends FloatingActionButtonAnimator {
  double _x;
  double _y;

  @override
  Offset getOffset({Offset begin, Offset end, double progress}) {
    _x = begin.dx + (end.dx - begin.dx) * progress;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x, _y);
  }

  @override
  Animation<double> getRotationAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}

String textBirthError = '''
According to the local policy, only users who is older than 16 yrs can be provided with further service. 
''';
String textDistance = '''
"(Title 1) Why add this?

-Help Nebula optimize your viewing experience (if you don't have any known issues you can add it later)

(Title 2) How to add this?
-Stand in front of a mirror, carefully hold a ruler in front of your face below the level of your right eye, align the zero end of the ruler with your pupil; measure the distance between your right and left pupil. The millimeter number is your IPD.
- If you want a more accurate result you can also ask your optician"
            ''';
