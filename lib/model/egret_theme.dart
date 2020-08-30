import 'package:flutter/material.dart';

class EgretTheme extends ChangeNotifier {
  MaterialColor themeColor;

  EgretTheme({this.themeColor = Colors.blue});

  changeColor(MaterialColor color) {
    if (color != themeColor) {
      themeColor = color;
    }
    notifyListeners();
  }
}
