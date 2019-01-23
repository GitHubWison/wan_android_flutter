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
  int _pageNo = 0;

  @override
  Widget build(BuildContext context) {
    return _getMainApp();
  }

  Widget _getMainApp() {
    PageController pageController = PageController(initialPage: _pageNo);
    return Scaffold(
          drawer: Drawer(
            child: DrawerPage(),
          ),
          appBar: AppBar(
            title: new Text("wan! android"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.search), onPressed: _toSearch)
            ],
          ),
          body: MainBodyState(_pageNo, _onPageChanged,pageController),
          bottomNavigationBar: BottomNavState(_pageNo,pageController),
        );
  }

  _onPageChanged(int no) {
    setState(() {
      _pageNo = no;
    });
  }

//跳转到搜索页面
  void _toSearch() {}
}

class MainBodyState extends StatelessWidget {
  final int _pageNo;
  final pageChanged;
  final pageController;
  MainBodyState(this._pageNo, this.pageChanged,this.pageController);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[Home(), Discovery()],
      physics: NeverScrollableScrollPhysics(),
      controller:pageController,
      onPageChanged: pageChanged,
    );
  }
}

class BottomNavState extends StatelessWidget {
  final int _pageNo;
  final PageController pageController;

  BottomNavState(this._pageNo, this.pageController);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("首页"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          title: Text("发现"),
        )
      ],
      currentIndex: _pageNo,
    );
  }
}

