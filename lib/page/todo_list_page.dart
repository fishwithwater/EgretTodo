import 'package:egret_todo/model/todo_item_model.dart';
import 'package:egret_todo/widget/todo_list_tile.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TodoListTile(TodoItemModel('今天写作业')),
          TodoListTile(TodoItemModel('今天写代码', subTitle: "Flutter")),
          TodoListTile(TodoItemModel('做饭', subTitle: "西红柿炒鸡蛋", finished: true))
        ],
      ),
    );
  }
}
