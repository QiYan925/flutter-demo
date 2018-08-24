import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loan_archive/tools.dart';

class VerifyCodeView extends StatefulWidget {
  VerifyCodeView(
      {Key key,
      this.name,
      this.keyboardType: TextInputType.number,
      this.hint,
      this.maxLength: 8,
      this.autofocus: false,
      this.controller,
      this.onGetCode})
      : assert(name != null),
        assert(hint != null),
        assert(maxLength > 0),
        assert(controller != null),
        super(key: key);
  final String name;
  final String hint;
  final int maxLength;
  final bool autofocus;
  final bool obscureText;
  final TextInputType keyboardType;
  final VerifyCodeController controller;
  final VoidCallback onGetCode;

  @override
  State<StatefulWidget> createState() {
    return new _VerifyCodeState();
  }
}

class _VerifyCodeState extends State<VerifyCodeView> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(
            top: AppDimens.bothTbSpacing,
            bottom: AppDimens.bothTbSpacing,
            left: AppDimens.bothSideSpacing,
            right: AppDimens.bothSideSpacing),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Padding(
              padding:
                  new EdgeInsets.only(right: AppDimens.bothSideSpacing * 2),
              child: new Text(widget.name,
                  style: new TextStyle(color: AppColors.title)),
            ),
            new Flexible(
                child: new TextField(
              keyboardType: widget.keyboardType,
              controller: widget.controller.textEditingController,
              onChanged: (text) {
                if (text.length > widget.maxLength) {
                  setState(() {
                    widget.controller.text =
                        text.substring(0, widget.maxLength);
                    widget.controller.selection =
                        TextSelection.collapsed(offset: widget.maxLength);
                  });
                }
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
              ),
              maxLengthEnforced: false,
//              autofocus: widget.autofocus,
              style: TextStyle(
                fontSize: AppDimens.h4,
                color: AppColors.title,
              ),
            )),
            new OutlineButton(
                child: new Text(
                  (widget.controller.time == 0
                      ? "获取验证码"
                      : (widget.controller.time.toString() + " 秒")),
                  style:
                      new TextStyle(color: getColor(), fontSize: AppDimens.h5),
                ),
                borderSide: BorderSide(
                    color: getColor(), width: AppDimens.dividerHeight),
                onPressed: widget.controller.time != 0
                    ? null
                    : () {
                        setState(() {
                          widget.controller.time = 60;
                          if (timer != null) timer.cancel();
                          timer = new Timer.periodic(new Duration(seconds: 1),
                              (timer) {
                            setState(() {
                              if (widget.controller.time != 0) {
                                widget.controller.time--;
                              } else {
                                timer.cancel();
                              }
                            });
                          });
                        });
                        widget.onGetCode();
                      })
          ],
        ));
  }

  Color getColor() {
    return widget.controller.time == 0
        ? Theme.of(context).accentColor
        : Colors.grey;
  }
}

class VerifyCodeController extends ValueNotifier<VerifyCodeValue> {
  VerifyCodeController(int time)
      : super(new VerifyCodeValue(
            time: time, textController: new TextEditingController()));

  set time(int time) {
    value = value.copyWith(time);
  }

  int get time => value.time;

  set text(String text) {
    value.textController.text = text;
  }

  set selection(TextSelection selection) {
    value.textController.selection = selection;
  }

  String get text => value.textController.text;

  TextEditingController get textEditingController => value.textController;

  void reset() {
    value = value.copyWith(0);
  }
}

class VerifyCodeValue {
  final int time;
  final TextEditingController textController;

  const VerifyCodeValue({this.time: 0, this.textController})
      : assert(time != null),
        assert(textController != null);

  VerifyCodeValue copyWith(int time) {
    return new VerifyCodeValue(
        time: time ?? this.time,
        textController: textController ?? this.textController);
  }
}
