import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color buttonColor;
  final String title;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  RoundedButton(
      {required this.buttonColor,
      required this.title,
      required this.onPressed,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
