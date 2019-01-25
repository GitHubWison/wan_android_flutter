import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';

//state
class WanAndroidState {
  final List<Article> homeArticleList;
  final List<BannerBean> homeBannerList;
  final List<KnowledgeSys> treeList;

//  知识体系的下一个详情页面
  final KnowledgeSys knowledgeInfo;
//  收藏
  final List<FavoriteArticle> favoriteList;
//登录后的用户信息存储　
  final UserInfo userInfo;

  WanAndroidState(
      {this.homeArticleList,
      this.homeBannerList,
      this.treeList,
      this.knowledgeInfo,
      this.favoriteList,
      this.userInfo,});
}

WanAndroidState reduce(WanAndroidState state, dynamic action) {
  return WanAndroidState(
      homeArticleList: homeArticleListReducer(state.homeArticleList, action),
      homeBannerList: homeBannerListReducer(state.homeBannerList, action),
      treeList: treeListReducer(state.treeList, action),
      knowledgeInfo: knowledgeInfo(state.knowledgeInfo, action),
      favoriteList: favoriteList(state.favoriteList, action),
      userInfo: userInfo(state.userInfo,action));
}

//reduce
var homeArticleListReducer = combineReducers<List<Article>>(
    [TypedReducer<List<Article>, HomeArticleListAction>(_getHomeArticleList)]);

var homeBannerListReducer = combineReducers<List<BannerBean>>([
  TypedReducer<List<BannerBean>, RefreshHomeBannerListAction>(
      _refreshHomeBannerList)
]);
var userInfo = combineReducers<UserInfo>([
  TypedReducer<UserInfo,RefreshUserInfoAction>(_getUserInfo)
]);
var treeListReducer = combineReducers<List<KnowledgeSys>>(
    [TypedReducer<List<KnowledgeSys>, RefreshTreeAction>(_rRefreshTree)]);
var knowledgeInfo = combineReducers<KnowledgeSys>([
  TypedReducer<KnowledgeSys, RefreshKnowledgeInfoAction>(_refreshKnowledgeInfo)
]);
var favoriteList = combineReducers<List<FavoriteArticle>>([
  TypedReducer<List<FavoriteArticle>, RefreshFavoriteListAction>(_refreshFavoriteList),
  TypedReducer<List<FavoriteArticle>, AddFavoriteListAction>(_addFavoriteArticle),
]);
UserInfo _getUserInfo(UserInfo userInfo, RefreshUserInfoAction action){
  return action.userInfo;
}
List<FavoriteArticle> _addFavoriteArticle(
    List<FavoriteArticle> articleList, AddFavoriteListAction action) {
  FavoriteArticle temp = action.article;
  int articleId = temp.id;
  int count = -1;
  for (int i = 0; i < articleList.length; i++) {
    var value = articleList[i];
    if (value.id == articleId) {
      articleList.removeAt(i);
      count = i;
    }
    break;
  }
  if (count == -1) {
    articleList.add(temp);
  } else {
    articleList.insert(count, temp);
  }

  return articleList;
}

List<Article> _getHomeArticleList(
    List<Article> list, HomeArticleListAction action) {
  return action.list;
}

List<BannerBean> _refreshHomeBannerList(
    List<BannerBean> state, RefreshHomeBannerListAction action) {
  return action.list;
}

List<KnowledgeSys> _rRefreshTree(
    List<KnowledgeSys> list, RefreshTreeAction action) {
  return action.list;
}

KnowledgeSys _refreshKnowledgeInfo(
    KnowledgeSys info, RefreshKnowledgeInfoAction action) {
  return action.info;
}

List<FavoriteArticle> _refreshFavoriteList(
    List<FavoriteArticle> list, RefreshFavoriteListAction action) {
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

class RefreshTreeAction {
  final List<KnowledgeSys> list;

  RefreshTreeAction(this.list);
}

class RefreshKnowledgeInfoAction {
  final KnowledgeSys info;

  RefreshKnowledgeInfoAction(this.info);
}

class RefreshFavoriteListAction {
  final List<FavoriteArticle> list;

  RefreshFavoriteListAction(this.list);
}

class AddFavoriteListAction {
  final FavoriteArticle article;

  AddFavoriteListAction(this.article);
}
class RefreshUserInfoAction{
  final UserInfo userInfo;

  RefreshUserInfoAction(this.userInfo);

}
