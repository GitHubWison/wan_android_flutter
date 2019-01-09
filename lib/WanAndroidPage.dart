import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/AboutMe.dart';
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
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: DrawerPage(),
      ),
      appBar: AppBar(
        leading: Text("首页"),
        title: new Text("wan! android"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: _toSearch)
        ],
      ),
      body: MainBodyState(_currentPage),
      bottomNavigationBar: BottomNavState(_currentPage, (index) {
        setState(() {
          _currentPage = index;
        });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    navList..add(Home())..add(Discovery())..add(AboutMe());
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
  final drawerTexts = [
    Text('收藏'),
    Text('设置'),
    Text('关于我们'),
    Text('退出'),
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
    return Row(
      children: <Widget>[icon, text],
    );
  }

  Widget _getUserInfo() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Icon(Icons.person),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('username'),
          )
        ],
      ),
    );
  }
}

class MainBodyState extends StatelessWidget {
  final currentPage;

  MainBodyState(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentPage,
      children: [Home(), Discovery(), AboutMe()],
    );
  }
}

class BottomNavState extends StatelessWidget {
  final currentPage;
  final tapTest;

  BottomNavState(this.currentPage, this.tapTest);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      items: [
        new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
        new BottomNavigationBarItem(
            icon: Icon(Icons.widgets), title: Text("发现")),
        new BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的"))
      ],
      fixedColor: Colors.blue,
      onTap: tapTest,
    );
  }
}
