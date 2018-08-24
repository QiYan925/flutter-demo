import 'package:flutter/material.dart';
import 'package:loan_archive/widgets/fading_circle.dart';

enum TipDialogType { NOTHING, LOADING, SUCCESS, FAIL, INFO }

class TipDialogIcon extends StatelessWidget {
  TipDialogIcon(this.type, {this.color: Colors.white});

  final TipDialogType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TipDialogType.SUCCESS:
        return new ImageIcon(
          AssetImage("res/drawable/icon_notify_done.png"),
          size: 35.0,
          color: color,
        );
      case TipDialogType.FAIL:
        return new ImageIcon(
          AssetImage("res/drawable/icon_notify_error.png"),
          size: 35.0,
          color: color,
        );
      case TipDialogType.INFO:
        return new ImageIcon(
          AssetImage("res/drawable/icon_notify_info.png"),
          size: 35.0,
          color: color,
        );
      case TipDialogType.LOADING:
        return new SpinKitFadingCircle(
          size: 35.0,
          color: color,
        );
      default:
        throw new Exception(
            "this type $type is not in TipDialogType: NOTHING, LOADING, SUCCESS, FAIL, INFO");
    }
  }
}

class TipDialog extends StatelessWidget {
  TipDialog({Key key, TipDialogType type: TipDialogType.NOTHING, this.tip})
      : assert(type != null),
        icon = type == TipDialogType.NOTHING ? null : new TipDialogIcon(type),
        bodyBuilder = null,
        color = const Color(0xbb000000),
        super(key: key);

  TipDialog.customIcon({Key key, this.icon, this.tip})
      : assert(icon != null || tip != null),
        bodyBuilder = null,
        color = const Color(0xbb000000),
        super(key: key);

  TipDialog.builder(
      {Key key, this.bodyBuilder, this.color: const Color(0xbb000000)})
      : assert(bodyBuilder != null),
        tip = null,
        icon = null,
        super(key: key);

  final String tip;
  final Widget icon;
  final WidgetBuilder bodyBuilder;
  final Color color;

  Widget _buildBody() {
    List<Widget> childs = [];
    if (icon != null) {
      childs.add(new Padding(
        padding: tip == null
            ? const EdgeInsets.all(20.0)
            : const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: icon,
      ));
    }
    if (tip != null) {
      childs.add(new Padding(
        padding: icon == null
            ? const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0)
            : const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: new Text(
          tip,
          textAlign: TextAlign.center,
          style: new TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ));
    }
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: childs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(15.0),
      child: new Container(
        constraints: icon == null || tip == null
            ? new BoxConstraints(minHeight: 50.0, minWidth: 100.0)
            : new BoxConstraints(minHeight: 90.0, minWidth: 120.0),
        color: color,
        child: bodyBuilder == null ? _buildBody() : bodyBuilder(context),
      ),
    );
  }
}