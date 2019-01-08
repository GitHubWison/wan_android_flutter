import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';
import 'package:wan_android_flutter/third_party/flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wan_android_flutter/component/Loading.dart';

class Discovery extends StatefulWidget {
  @override
  DiscoveryState createState() {
    return DiscoveryState();
  }
}

class DiscoveryState extends State<Discovery> with WidgetsBindingObserver {
  String test = "";
  List<KnowledgeSys> list = List();

  @override
  Widget build(BuildContext context) {
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
}

class KnowledgeSysTile extends StatelessWidget {
  final KnowledgeSys knowledgeSys;

  KnowledgeSysTile(this.knowledgeSys);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/knowledge_article_list');
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Text(
              knowledgeSys.name,
              style: TextStyle(
                  color: Colors.blue, fontSize: 25, letterSpacing: 5),
            ),
            Wrap(children: knowledgeSys.children.map((m) {
              return KnowledgeItem(m.name);
            }).toList(),),

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
    return Container(child: Text(knowledgeName),
      decoration: BoxDecoration(color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      width: 2,
      padding: EdgeInsets.all(10),);
  }

}
