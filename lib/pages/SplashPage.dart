import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android_flutter/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  var configTips = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(configTips),
            RaisedButton(onPressed: (){
              addOne();
            },),
            RaisedButton(onPressed: (){
              searchAll();
            },)
          ],
        ),
      ),
    );
  }

  void addOne(){
    ()async{
//      await db.addTest()
    }();
  }

  void searchAll(){
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushNamedAndRemoveUntil(wanAndroidRoute,(route) => route == null);
    });
  }
}
