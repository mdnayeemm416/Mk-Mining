import 'package:flutter/cupertino.dart';

void appLoader(BuildContext context) {
  CupertinoAlertDialog alert= const CupertinoAlertDialog(
    content: Row(
      children: [
        CupertinoActivityIndicator(),
        Text("  Please wait"),
      ],),
  );
  showCupertinoDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}