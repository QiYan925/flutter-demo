import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';

class ServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ServicePageState();
  }
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppStrings.service),
      ),
      body: new Center(
        child: new Text(AppStrings.service + " Page"),
      ),
    );
  }
}
