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
    return new Scaffold( appBar: AppBar(
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
      }),);
  }

  @override
  void initState() {
    super.initState();
    navList..add(Home())..add(Discovery())..add(AboutMe());
  }

//跳转到搜索页面
  void _toSearch() {}
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
