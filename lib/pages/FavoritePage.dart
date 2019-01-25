import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticleList.dart';
import 'package:wan_android_flutter/component/FavoriteArticleList.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';

class FavoritePage extends StatefulWidget {
  @override
  FavoriteState createState() {
    return FavoriteState();
  }
}
class FavoriteState extends State<FavoritePage> {
  int _pageNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
      ),
      body: StoreConnector<WanAndroidState, List<FavoriteArticle>>(
        converter: (store) {
          return store.state.favoriteList;
        },
        builder: (BuildContext context, List vm) {
          return FavoriteArticleList(vm, _onRefresh, _onLoadMore);
        },
      ),
    );
  }

  Store<WanAndroidState> _getStore() {
    return StoreProvider.of(context);
  }

  Future<Null> _onRefresh() async{
    _pageNo = 0;
    WanAndroidRepository.instance.getFavoriteListFromNet(_getStore(), _pageNo);
    return null;
  }

  Future<Null> _onLoadMore() async{
    _pageNo += 1;
     WanAndroidRepository.instance.getFavoriteListFromNet(_getStore(), _pageNo);
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onRefresh();
  }
}
