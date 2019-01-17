import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticleList.dart';
import 'package:wan_android_flutter/component/Loading.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';
import 'package:wan_android_flutter/pages/Home.dart';

class KnowledgeArticle extends StatelessWidget {
  final KnowledgeSys knowledgeSys;

  KnowledgeArticle(this.knowledgeSys);

  @override
  Widget build(BuildContext context) {
    final list = knowledgeSys.children;

    if (list == null || list.length == 0) {
      return Loading();
    } else {
      return DefaultTabController(
        length: list.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(knowledgeSys.name),
            ),
            body: Scaffold(
              appBar: TabBar(
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.blueGrey,
                isScrollable: true,
                tabs: list.map((m) {
                  return Tab(
                    text: m.name,
                  );
                }).toList(),
              ),
              body: TabBarView(
                children: list.map((m) {
                  return KnowledgeArticleList(m.id);
                }).toList(),
              ),
            )),
      );
    }
  }
}

// ignore: must_be_immutable
class KnowledgeArticleList extends StatefulWidget {
  int cid = 0;

  KnowledgeArticleList(this.cid);

  @override
  KnowledgeArticleListState createState() {
    return KnowledgeArticleListState(cid);
  }
}

class KnowledgeArticleListState extends State<KnowledgeArticleList> with AutomaticKeepAliveClientMixin<KnowledgeArticleList>{
  int cid = 0;
  List<Article> listData = new List();
  int pageNo = 0;

  KnowledgeArticleListState(this.cid);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (listData == null || listData.length == 0) {
      return Loading();
    } else {
      return ArticleList(listData, _refreshData, _loadMoreData);
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _getDataWithOffset(int offset, {doNext(List<Article> listParam)})  {
    WanAndroidDio.instance.doGet('article/list/$offset/json?cid=$cid',
        onSuccess: (WanAndroidBean data) {
      Data allData = Data.fromJson(data.data);
      List<Article> tempList = allData.datas;
      doNext(tempList);
    });
  }

  Future<Null> _refreshData() async{
    _getDataWithOffset(0, doNext: (tempList) {
      setState(() {
        listData.clear();
        listData.addAll(tempList);
        pageNo = 0;
      });
      return null;
    });
  }

  Future<Null> _loadMoreData() async{
    pageNo++;
    _getDataWithOffset(pageNo, doNext: (tempList) {
      setState(() {
        listData.addAll(tempList);
      });
      return null;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
