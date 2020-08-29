import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '白鹭清单',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Navigator(onGenerateRoute: (settings) {
          return MaterialPageRoute<void>(builder: (context) => TabNavigator());
        }));
  }
}
