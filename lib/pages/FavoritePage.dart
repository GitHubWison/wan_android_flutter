import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticleList.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';

class FavoritePage extends StatefulWidget {
  @override
  FavoriteState createState() {
    return FavoriteState();
  }
}
// ArticleList(vm, _onRefresh, _onLoadMore)
class FavoriteState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("收藏"),),
      body: StoreConnector<WanAndroidState, List<Article>>(
        converter: (store) {
          return store.state.favoriteList;
        },
        builder: (BuildContext context, List vm) {
          return RaisedButton(onPressed: () {
            WanAndroidRepository.instance.getFavoriteListFromNet(_getStore(),0);
          },child: Text('获取数据'),);
        },
      ),
    );
  }

  Store<WanAndroidState> _getStore() {
    return StoreProvider.of(context);
  }

  Future<Null> _onRefresh() {
    return null;
  }

  Future<Null> _onLoadMore() {
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WanAndroidRepository.instance.getFavoriteArticleList(_getStore());
  }
}
