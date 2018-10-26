import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {

  final String buttonName;
  final VoidCallback onPressed;
  TextStyle textStyle, buttonTextStyle;
  final EdgeInsets padding;

  TextButton(
    this.buttonName,
    this.onPressed,
    this.buttonTextStyle,
    [this.padding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)]
  );

  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      padding: padding,
      child: new Text(
        buttonName,
        textAlign: TextAlign.center,
        style: buttonTextStyle
      ),
      onPressed: onPressed,
    ));
  }
}

// class PictureButton extends StatelessWidget {

//   final VoidCallback onPressed;

//   PictureButton(this.onPressed);

//   @override
//   Widget build(BuildContext context) {
//     return new FlatButton(
//       onPressed: onPressed,
//       //TODO: Figure out how to make image into button
//       child: new Text("Test"),
//     );
//   }
// }