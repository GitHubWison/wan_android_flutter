import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/HomeArticleListTile.dart';
import 'package:wan_android_flutter/component/Loading.dart';

class ArticleList extends StatelessWidget {
  final List<Article> list;
  final onRefresh;
  final onLoadMore;

  ArticleList(
      this.list,
      this.onRefresh,
      this.onLoadMore,
      );

  @override
  Widget build(BuildContext context) {
    if (list.length==0) {
      return Loading();
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _loadMoreScrollController(),
        itemBuilder: (context, index) {
          return HomeArticleListTile(list[index]);
        },
        itemCount: list.length,
      ),
    );
  }

  ScrollController _loadMoreScrollController() {
    ScrollController _tempScrollController = new ScrollController();
    _tempScrollController.addListener(() {
      if (_tempScrollController.position.pixels ==
          _tempScrollController.position.maxScrollExtent) {
        onLoadMore();
      }
    });
    return _tempScrollController;
  }
}