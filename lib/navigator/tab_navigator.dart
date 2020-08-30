import 'package:animations/animations.dart';
import 'package:egret_todo/model/egret_theme.dart';
import 'package:egret_todo/model/todo_item_model.dart';
import 'package:egret_todo/page/setting_page.dart';
import 'package:egret_todo/page/todo_Item_detail_page.dart';
import 'package:egret_todo/page/todo_list_page.dart';
import 'package:egret_todo/util/NavigatorUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
const double _fabDimension = 56;
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 0;
  static final List<String> _titleList = ['白鹭清单', '我的'];
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleList[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.settings,color:colorScheme.surface),
            onPressed: (){
              NavigatorUtil.push(context, SettingPage());
            },
          )
        ],
      ),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        openBuilder: (context, openContainer) => TodoItemDetailPage(null),
        // closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: colorScheme.secondary,
        closedBuilder: (context, openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _controller,
        children: <Widget>[
          TodoListPage(),
          Container(
            child: Center(child: Text('2')),
          ),
        ],
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem(Icons.format_list_bulleted, 0),
            _bottomItem(Icons.account_circle, 1),
          ]),
    );
  }

  _bottomItem(IconData icon, int index) {
    return BottomNavigationBarItem(icon: Icon(icon), title: new Container());
  }
}
