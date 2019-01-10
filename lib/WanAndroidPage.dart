import 'package:flutter/material.dart';
import 'package:wan_android_flutter/component/ArticlePadding.dart';
import 'package:wan_android_flutter/pages/Discovery.dart';
import 'package:wan_android_flutter/pages/Home.dart';

class WanAndroidPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WanAndroidPageState();
  }
}

class WanAndroidPageState extends State<WanAndroidPage> {
  final List navList = new List();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: DrawerPage(),
          ),
          appBar: AppBar(
            title: new Text("wan! android"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.search), onPressed: _toSearch)
            ],
          ),
          body: MainBodyState(),
          bottomNavigationBar: BottomNavState(),
        ));
  }

  @override
  void initState() {
    super.initState();
    navList..add(Home())..add(Discovery());
  }

//跳转到搜索页面
  void _toSearch() {}
}

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
        _getItemWidget(drawerIcons[0], drawerTexts[0]),
        _getItemWidget(drawerIcons[1], drawerTexts[1]),
        _getItemWidget(drawerIcons[2], drawerTexts[2]),
        _getItemWidget(drawerIcons[3], drawerTexts[3]),
      ],
    );
  }

  Widget _getItemWidget(Icon icon, Text text) {
    return InkWell(
      onTap: () {},
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

class MainBodyState extends StatelessWidget {
//  final currentPage;

  MainBodyState();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [Home(), Discovery()],
    );
  }
}

class BottomNavState extends StatelessWidget {
  BottomNavState();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      indicator: null,
      tabs: <Widget>[
        Tab(
          text: "首页",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "发现",
          icon: Icon(Icons.widgets),
        )
      ],
    );
  }
}
/*new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
        new BottomNavigationBarItem(
            icon: Icon(Icons.widgets), title: Text("发现")),*/
