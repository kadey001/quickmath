import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {

  final String buttonName;
  final VoidCallback onPressed;
  final TextStyle buttonTextStyle;
  final EdgeInsets padding;

  TextButton(
    this.buttonName,
    this.onPressed,
    this.buttonTextStyle,
    [this.padding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)]
  );

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: padding,
      child: Text(
        buttonName,
        textAlign: TextAlign.center,
        style: buttonTextStyle
      ),
      onPressed: onPressed,
    );
  }
}