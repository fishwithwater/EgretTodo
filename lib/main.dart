import 'package:egret_todo/db/db_provider/todo_item_db_provider.dart';
import 'package:egret_todo/model/egret_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigator/tab_navigator.dart';

void main() => {
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider<EgretTheme>(
            create: (_) => EgretTheme(),
          ),
          FutureProvider(create: (_) => TodoItemDbProvider().getAll())
        ],
        child: MyApp(),
      ))
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<EgretTheme, MaterialColor>(
      selector: (context, egretTheme) => egretTheme.themeColor,
      shouldRebuild: (pre, next) => pre != next,
      builder: (_, themeColor, __) => MaterialApp(
          title: '白鹭清单',
          theme: ThemeData(
            primarySwatch: themeColor,
          ),
          home: Navigator(onGenerateRoute: (settings) {
            return MaterialPageRoute<void>(
                builder: (context) => TabNavigator());
          })),
    );
  }
}
