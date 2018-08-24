import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';
import 'package:loan_archive/pages/service/message.dart';
import 'package:loan_archive/pages/service/search.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Padding(
            padding: new EdgeInsets.only(),
            child: new Center(
                child: new ClipRRect(
              borderRadius: const BorderRadius.all(
                  const Radius.circular(AppDimens.clipRect_30)),
              child: new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppPage.SEARCH);
                  },
                  child: new Container(
                    color: Colors.white24,
                    width: double.maxFinite,
                    padding: new EdgeInsets.only(
                        top: AppDimens.bothTbSpacing,
                        bottom: AppDimens.bothTbSpacing),
                    child: new Text(AppStrings.search,
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: AppDimens.h4)),
                  )),
            )),
          ),
          actions: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(right: AppDimens.bothSideSpacing),
              child: new IconButton(
                  icon: new Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppPage.MESSAGE)),
            )
          ],
        ),
        body: new Center(
          child: new Text(AppStrings.home + " Page"),
        ),
    );
  }
}
