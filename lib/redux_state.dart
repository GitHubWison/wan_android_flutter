import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';

//state
class WanAndroidState {
  final List<Article> homeArticleList;
  final List<BannerBean> homeBannerList;
  final List<KnowledgeSys> treeList;
//  知识体系的下一个详情页面
  final KnowledgeSys knowledgeInfo;

  WanAndroidState({this.homeArticleList, this.homeBannerList,this.treeList,this.knowledgeInfo});
}

WanAndroidState reduce(WanAndroidState state, dynamic action) {
  return WanAndroidState(
      homeArticleList: homeArticleListReducer(state.homeArticleList,action),
      homeBannerList: homeBannerListReducer(state.homeBannerList,action),
      treeList: treeListReducer(state.treeList,action),
      knowledgeInfo:knowledgeInfo(state.knowledgeInfo,action));
}

//reduce
var homeArticleListReducer = combineReducers<List<Article>>(
    [TypedReducer<List<Article>, HomeArticleListAction>(_getHomeArticleList)]);

var homeBannerListReducer = combineReducers<List<BannerBean>>([
  TypedReducer<List<BannerBean>, RefreshHomeBannerListAction>(
      _refreshHomeBannerList)
]);

var treeListReducer = combineReducers<List<KnowledgeSys>>(
  [TypedReducer<List<KnowledgeSys>,RefreshTreeAction>(_rRefreshTree)]
);
var knowledgeInfo = combineReducers<KnowledgeSys>([TypedReducer<KnowledgeSys,RefreshKnowledgeInfoAction>(_refreshKnowledgeInfo)]);

List<Article> _getHomeArticleList(
    List<Article> list, HomeArticleListAction action) {
  return action.list;
}

List<BannerBean> _refreshHomeBannerList(
    List<BannerBean> state, RefreshHomeBannerListAction action) {
  return action.list;
}
List<KnowledgeSys> _rRefreshTree(List<KnowledgeSys> list ,RefreshTreeAction action){
  return action.list;
}
KnowledgeSys _refreshKnowledgeInfo(KnowledgeSys info,RefreshKnowledgeInfoAction action)
{
  return action.info;
}

//action
class HomeArticleListAction {
  final List<Article> list;

  HomeArticleListAction(this.list);
}

class RefreshHomeBannerListAction {
  final List<BannerBean> list;

  RefreshHomeBannerListAction(this.list);
}
class RefreshTreeAction{
  final List<KnowledgeSys> list;

  RefreshTreeAction(this.list);

}
class RefreshKnowledgeInfoAction{
  final KnowledgeSys info;

  RefreshKnowledgeInfoAction(this.info);

}
