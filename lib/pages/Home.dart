import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/WanAndroidNativeChannel.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/HomeArticleListTile.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';
import 'package:wan_android_flutter/component/Loading.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  final List<Article> list = new List();
  final List<BannerBean> bannerList = new List();
  int pageNo = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: (bannerList == null || bannerList.length == 0
              ? Loading()
              : BannerView(bannerList)),
          flex: 1,
        ),
        Expanded(
          child: (list == null || list.length == 0)
              ? Loading()
              : ArticleList(list, _refreshArticleData, _addMorArticleData),
          flex: 3,
        )
      ],
    );
  }

  refreshBannerData() async {
    WanAndroidDio.instance.doGet('http://www.wanandroid.com/banner/json',
        onSuccess: (WanAndroidBean data) {
      List tempList = data.data;
      List<BannerBean> tempBannerList = tempList.map((m) {
        return BannerBean.fromJson(m);
      }).toList();

      setState(() {
        bannerList.clear();
        bannerList.addAll(tempBannerList);
      });
    });
  }

  _getArticleDataWithOffset(int offset, {callBack}) {
    WanAndroidDio.instance.doGet("article/list/$offset/json",
        onSuccess: (WanAndroidBean data) {
      Data tempData = Data.fromJson(data.data);
      List<Article> articleList = tempData.datas;
      callBack(articleList);
    });
  }

  Future<Null> _refreshArticleData() async {
    _getArticleDataWithOffset(0, callBack: (List<Article> articleList) {
      setState(() {
        list.clear();
        list.addAll(articleList);
        pageNo = 0;
      });
      return null;
    });
  }

  Future<void> _addMorArticleData() async {
    pageNo += 1;
    _getArticleDataWithOffset(pageNo, callBack: (tempList) {
      setState(() {
        list.addAll(tempList);
      });
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshArticleData();
    refreshBannerData();
  }

  @override
  bool get wantKeepAlive => true;
}

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

class BannerView extends StatelessWidget {
  final List<BannerBean> list;

  BannerView(this.list);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: list.length,
      itemBuilder: (context, index) {
        BannerBean temp = list[index];
        return Image.network(
          temp.imagePath,
          fit: BoxFit.fill,
        );
      },
      loop: true,
      autoplay: true,
      pagination: SwiperCustomPagination(builder: (context, config) {
        BannerBean temp = list[config.activeIndex];
        return Text(temp.title);
      }),
    );
  }
}
