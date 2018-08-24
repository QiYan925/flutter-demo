import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppStrings.message),
      ),
      body: new Center(
        child: new Text(AppStrings.message + "Page"),
      ),
    );
  }
}
