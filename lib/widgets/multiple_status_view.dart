import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loan_archive/tools.dart';
import 'dart:async';

class MultipleStatusView extends StatefulWidget {
  final Widget body;
  final MultipleStatusController controller;

  MultipleStatusView(this.body, this.controller)
      : assert(body != null),
        assert(controller != null),
        super(key: controller.globalKey);

  @override
  State<StatefulWidget> createState() {
    return _MultipleStatusState();
  }

  void setStatus(TipDialogType status, {String text, VoidCallback callback}) {
    controller.status = status;
    controller.text = text != null ? text : "加载中";
    if (status == TipDialogType.NOTHING || status == null) {
      controller.globalKey.currentState.dismiss();
    } else {
      controller.globalKey.currentState.show();
      if (status != TipDialogType.LOADING)
        new Future.delayed(
            new Duration(seconds: status == TipDialogType.INFO ? 1 : 2), () {
          controller.clear();
          controller.globalKey.currentState.dismiss();
          if (callback != null) callback();
        });
    }
  }
}

class _MultipleStatusState extends State<MultipleStatusView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[widget.body, Positioned.fill(child: get())]);
  }

  Widget get() {
    if (widget.controller.status == TipDialogType.NOTHING ||
        widget.controller.status == null) {
      return new SizedBox.expand();
    } else {
      return new Container(
        color: Colors.black.withAlpha(0.3 * 255 ~/ 1),
        padding: EdgeInsets.only(bottom: kToolbarHeight),
        child: new Center(
          child: new TipDialog(
              type: widget.controller.status, tip: widget.controller.text),
        ),
      );
    }
  }

  void dismiss() {
    setState(() {
      widget.controller.clear();
    });
  }

  void show() {
    setState(() {});
  }
}

class MultipleStatusController extends ValueNotifier<MultipleStatusValue> {
  MultipleStatusController(TipDialogType status)
      : super(new MultipleStatusValue(
            status: status, globalKey: new GlobalKey<_MultipleStatusState>()));

  TipDialogType get status => value.status;

  set status(TipDialogType status) {
    value = value.copyWith(text: value.text, status: status);
  }

  set text(String text) {
    value = value.copyWith(text: text, status: value.status);
  }

  String get text => value.text;

  GlobalKey<_MultipleStatusState> get globalKey => value.globalKey;

  void clear() {
    value = value.copyWith(text: "", status: TipDialogType.NOTHING);
  }
}

class MultipleStatusValue {
  final String text;
  final TipDialogType status;
  final GlobalKey<_MultipleStatusState> globalKey;

  const MultipleStatusValue(
      {this.text: '', this.status: TipDialogType.LOADING, this.globalKey})
      : assert(text != null),
        assert(status != null),
        assert(globalKey != null);

  MultipleStatusValue copyWith({String text, TipDialogType status}) {
    return new MultipleStatusValue(
        text: text ?? this.text,
        status: status ?? this.status,
        globalKey: globalKey ?? this.globalKey);
  }
}
