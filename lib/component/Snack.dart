import 'package:flutter/material.dart';
class Snack{
  static void show(BuildContext context,String tips)
  {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(tips==null?'':tips)));
  }
}