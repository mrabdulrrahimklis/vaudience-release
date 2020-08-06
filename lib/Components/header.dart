import 'package:flutter/material.dart';

AppBar header(context, { bool isAppTitle = false, String titleText, backButton = false }) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    iconTheme: IconThemeData(
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      isAppTitle ? 'vaudience' : titleText,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: isAppTitle ? 50.0 : 30,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
