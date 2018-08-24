import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loan_archive/tools.dart';

class InputEditView extends StatefulWidget {
  InputEditView({
    Key key,
    this.name,
    this.keyboardType: TextInputType.text,
    this.hint,
    this.maxLength: 500,
    this.autofocus: false,
    this.obscureText: false,
    this.controller,
  })  : assert(name != null),
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
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return new _InputEditState();
  }
}

class _InputEditState extends State<InputEditView> {
  bool _hasEye = false;

  @override
  void initState() {
    super.initState();
    _hasEye = widget.obscureText;
  }

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
              controller: widget.controller,
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
              obscureText: _hasEye,
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
            !widget.obscureText
                ? new Divider()
                : new IconButton(
                    onPressed: () {
                      setState(() {
                        _hasEye = !_hasEye;
                      });
                    },
                    icon: new Icon(
                      Icons.remove_red_eye,
                      color:
                          _hasEye ? Colors.grey : Theme.of(context).accentColor,
                    ))
          ],
        ));
  }
}
