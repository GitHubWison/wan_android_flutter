import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/Loading.dart';
import 'package:wan_android_flutter/pages/KnowLedgeArticleV2.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';
import 'package:wan_android_flutter/third_party/flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class Discovery extends StatefulWidget {
  @override
  DiscoveryState createState() {
    return DiscoveryState();
  }
}

class DiscoveryState extends State<Discovery>
    with AutomaticKeepAliveClientMixin<Discovery> {
  Store<WanAndroidState> _getWanAndroidStore() {
    return StoreProvider.of<WanAndroidState>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<WanAndroidState, List<KnowledgeSys>>(
      converter: (store) {
        return store.state.treeList;
      },
      builder: (BuildContext context, List vm) {
        if (vm == null || vm.length == 0) {
          return Loading();
        } else {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return KnowledgeSysTile(vm[index], (){
                WanAndroidRepository.instance.getKnowledgeInfo(_getWanAndroidStore(), vm[index]);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KnowLedgeArticleV2()));
//                Navigator.of(context).pushNamed(knowledgeArticleRoute);
              });
            },
            staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
            itemCount: vm.length,
          );
        }
      },
    );
  }
  void toInfoPage(){

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_getWanAndroidStore().state.treeList.length==0) {
      _refreshData();
    }

  }

  void _refreshData() {
    WanAndroidRepository.instance.getTree(_getWanAndroidStore());
  }

  @override
  bool get wantKeepAlive => true;
}

class KnowledgeSysTile extends StatelessWidget {
  final KnowledgeSys knowledgeSys;
  final toNext;

  KnowledgeSysTile(this.knowledgeSys, this.toNext);

  @override
  Widget build(BuildContext context) {
    String articleDetail = '';
    for (var value in knowledgeSys.children) {
      articleDetail += '${value.name}  ';
    }
    return Card(
      child: InkWell(
        onTap: () {

          toNext();
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                knowledgeSys.name,
                style: TextStyle(
                    color: Colors.blue, fontSize: 25, letterSpacing: 5),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                articleDetail,
                style:
                    TextStyle(color: Colors.grey, fontSize: 20, wordSpacing: 5),
              ),
            )
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
