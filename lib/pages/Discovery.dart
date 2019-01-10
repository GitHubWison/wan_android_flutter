import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';
import 'package:wan_android_flutter/pages/KnowLedgeArticle.dart';
import 'package:wan_android_flutter/third_party/flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wan_android_flutter/component/Loading.dart';

class Discovery extends StatefulWidget {
  @override
  DiscoveryState createState() {
    return DiscoveryState();
  }
}

class DiscoveryState extends State<Discovery> with AutomaticKeepAliveClientMixin<Discovery> {
  String test = "";
  List<KnowledgeSys> list = List();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (list == null || list.length == 0) {
      return Loading();
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return KnowledgeSysTile(list[index]);
        },
        staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
        itemCount: list.length,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    WanAndroidDio.instance.doGet("tree/json", onSuccess: (WanAndroidBean data) {
      List temp = data.data;
      List<KnowledgeSys> tempKnowledgeList = temp.map((m) {
        return KnowledgeSys.fromJson(m);
      }).toList();
      setState(() {
        list.clear();
        list.addAll(tempKnowledgeList);
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

}

class KnowledgeSysTile extends StatelessWidget {
  final KnowledgeSys knowledgeSys;

  KnowledgeSysTile(this.knowledgeSys);

  @override
  Widget build(BuildContext context) {
    String articleDetail = '';
    for (var value in knowledgeSys.children) {
      articleDetail += '${value.name}  ';
    }
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return KnowledgeArticle(knowledgeSys);
          }));
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Align(alignment: Alignment.centerLeft,child: Text(
              knowledgeSys.name,
              style:
              TextStyle(color: Colors.blue, fontSize: 25, letterSpacing: 5),
            ),),
          Align(alignment: Alignment.centerLeft,child:
            Text(
              articleDetail,
              style: TextStyle(color: Colors.grey, fontSize: 20,wordSpacing: 5),
            ),)
          ]),
        ),
      ),
    );
  }
}

class KnowledgeItem extends StatelessWidget {
  final String knowledgeName;

  const KnowledgeItem(this.knowledgeName);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(knowledgeName),
    );
  }
}
