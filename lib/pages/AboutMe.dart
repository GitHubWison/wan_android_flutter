import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  @override
  AboutMeState createState() => AboutMeState();
}

class AboutMeState extends State<AboutMe> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context) {
    return Text("AboutMe");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('AboutMeState==initState');
  }

}
