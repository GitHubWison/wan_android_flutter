import 'package:flutter/material.dart';
import 'package:wan_android_flutter/component/ArticlePadding.dart';
import 'package:wan_android_flutter/pages/FavoritePage.dart';
import 'package:wan_android_flutter/pages/LoginPage.dart';
import 'package:wan_android_flutter/routes.dart';
class DrawerPage extends StatelessWidget {
  final drawerIcons = [
    Icon(
      Icons.favorite,
      color: Colors.black,
    ),
    Icon(
      Icons.settings,
      color: Colors.black,
    ),
    Icon(
      Icons.info_outline,
      color: Colors.black,
    ),
    Icon(
      Icons.power_settings_new,
      color: Colors.black,
    )
  ];
  static const textStyle = TextStyle(color: Colors.black, fontSize: 18);
  final drawerTexts = [
    Text(
      '收藏',
      style: textStyle,
    ),
    Text('设置', style: textStyle),
    Text('关于我们', style: textStyle),
    Text('退出', style: textStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _getUserInfo(),
        _getItemWidget(drawerIcons[0], drawerTexts[0], onclick: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return FavoritePage();
          }));
        }),
        _getItemWidget(drawerIcons[1], drawerTexts[1], onclick: () {
          Navigator.of(context).pushNamed(loginRoute);
        }),
        _getItemWidget(drawerIcons[2], drawerTexts[2]),
        _getItemWidget(drawerIcons[3], drawerTexts[3]),
      ],
    );
  }


  Widget _getItemWidget(Icon icon, Text text, {onclick}) {
    return InkWell(
      onTap: onclick,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            icon,
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: text,
            )
          ],
        ),
      ),
    );
  }

  Widget _getUserInfo() {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black12,
              minRadius: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            ArticlePadding(),
            Text(
              'username',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}


