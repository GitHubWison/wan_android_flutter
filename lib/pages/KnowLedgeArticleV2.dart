import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticleList.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';

class KnowLedgeArticleV2 extends StatefulWidget {
  @override
  KnowLedgeArticleV2State createState() => KnowLedgeArticleV2State();
}

class KnowLedgeArticleV2State extends State<KnowLedgeArticleV2> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<WanAndroidState, KnowledgeSys>(
      converter: (store) {
        return store.state.knowledgeInfo;
      },
      builder: (BuildContext context, KnowledgeSys vm) {
        return _knowLedgeMainBody(vm);
      },
    );
  }

  Store<WanAndroidState> _getState() {
    return StoreProvider.of(context);
  }

  Widget _knowLedgeMainBody(KnowledgeSys info) {
    var index = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(info.name),
      ),
      body: DefaultTabController(
          length: info.children.length,
          child: Scaffold(
            appBar: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.blueGrey,
              isScrollable: true,
              tabs: info.children.map((m) {
                return Tab(
                  text: m.name,
                );
              }).toList(),
            ),
            body: TabBarView(
              children: info.children.map((m) {
                Widget w =
                    TreeArticleList(index, m.id, m.children, _getState());
                index++;
                return w;
              }).toList(),
            ),
          )),
    );
  }
}

class TreeArticleList extends StatefulWidget{
//  用于指示当前页面为第几个页面
  final int indicateIndex;
  final int cid;
  final List<Article> list;
  final Store<WanAndroidState> store;

  TreeArticleList(this.indicateIndex, this.cid, this.list, this.store);

  @override
  TreeArticleListState createState() {
    return new TreeArticleListState();
  }
}

class TreeArticleListState extends State<TreeArticleList> with AutomaticKeepAliveClientMixin<TreeArticleList> {
  int pageNo = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArticleList(widget.list, onRefresh, onLoadMore);
  }

  Future<Null> onRefresh() async {
    pageNo = 0;
    getData();
    return null;
  }

  Future<Null> onLoadMore() async{
    pageNo++;
    getData();
    return null;
  }

  void getData() {
    WanAndroidRepository.instance.getKnowledgeUnderTree(
        widget.store, widget.cid, pageNo, widget.indicateIndex);
  }

  @override
  bool get wantKeepAlive => true;
}
