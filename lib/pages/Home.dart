import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticleList.dart';
import 'package:wan_android_flutter/component/BannerView.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  int pageNo = 0;

  Store<WanAndroidState> _getWanAndroidState() {
    return StoreProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshArticleData();
    refreshBannerData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        StoreConnector<WanAndroidState, List<BannerBean>>(
          converter: (store) {
            return store.state.homeBannerList;
          },
          builder: (BuildContext context, List vm) => Expanded(
                child: BannerView(vm),
                flex: 1,
              ),
        ),
        StoreConnector<WanAndroidState, List<Article>>(
          builder: (BuildContext context, List vm) {
            return Expanded(
              child: ArticleList(vm, _refreshArticleData, _addMorArticleData),
              flex: 3,
            );
          },
          converter: (store) {
            return store.state.homeArticleList;
          },
        )
      ],
    );
  }

  refreshBannerData() async {
    WanAndroidRepository.instance.getHomeBannerList(_getWanAndroidState());
  }

  Future<Null> _refreshArticleData() async {
    pageNo = 0;
    WanAndroidRepository.instance.getHomeArticleListWithPageNo(_getWanAndroidState());
    return null;
  }

  Future<Null> _addMorArticleData() async {
    pageNo += 1;
    WanAndroidRepository.instance.getHomeArticleListWithPageNo(_getWanAndroidState(),
        pageNo: pageNo);
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
