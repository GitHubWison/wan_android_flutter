import 'package:flutter/material.dart';

class KnowledgeArticleList extends StatefulWidget {
  @override
  KnowLedgeArticleState createState() {
    return KnowLedgeArticleState();
  }
}

class KnowLedgeArticleState extends State<KnowledgeArticleList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("知识体系"),),
      body: TabBarView(children: [
        Text('111111'),
        Text('222222'),
        Text('33333'),
      ], controller: new TabController(vsync: this, length: 3)),
    );
  }
}
