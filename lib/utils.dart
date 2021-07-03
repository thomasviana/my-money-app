import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Utils {
  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        useRootNavigator: true,
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(fontSize: 24)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
