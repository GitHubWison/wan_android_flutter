import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';

//state
class WanAndroidState {
  final List<Article> homeArticleList;
  final List<BannerBean> homeBannerList;

  WanAndroidState({this.homeArticleList, this.homeBannerList});
}

WanAndroidState reduce(WanAndroidState state, dynamic action) {
  return WanAndroidState(
      homeArticleList: homeArticleListReducer(state.homeArticleList,action),
      homeBannerList: homeBannerListReducer(state.homeBannerList,action));
}

//reduce
var homeArticleListReducer = combineReducers<List<Article>>(
    [TypedReducer<List<Article>, HomeArticleListAction>(_getHomeArticleList)]);

var homeBannerListReducer = combineReducers<List<BannerBean>>([
  TypedReducer<List<BannerBean>, RefreshHomeBannerListAction>(
      _refreshHomeBannerList)
]);

List<Article> _getHomeArticleList(
    List<Article> list, HomeArticleListAction action) {
  return action.list;
}

List<BannerBean> _refreshHomeBannerList(
    List<BannerBean> state, RefreshHomeBannerListAction action) {
  return action.list;
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
