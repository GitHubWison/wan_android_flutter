import 'package:flutter/material.dart';
import 'package:wan_android_flutter/component/DrawerPage.dart';
import 'package:wan_android_flutter/pages/Discovery.dart';
import 'package:wan_android_flutter/pages/Home.dart';

class WanAndroidPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return new WanAndroidPageState();
  }
}

class WanAndroidPageState extends State<WanAndroidPage> {


  @override
  Widget build(BuildContext context) {
    return _getMainApp();
  }

  DefaultTabController _getMainApp() {
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

//跳转到搜索页面
  void _toSearch() {}
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
