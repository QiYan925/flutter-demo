import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppStrings.search),
      ),
      body: new Center(
        child: new Text(AppStrings.search + "Page"),
      ),
    );
  }
}
