import 'package:flutter/cupertino.dart';

Future<void> appAlertDialog(BuildContext context, String title, String content,
    {List<Widget> actions = const <Widget>[],
    bool barrierDismissible = false}) async {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: content.isEmpty ? null : Text(content),
      actions: actions,
    ),
  );
}
