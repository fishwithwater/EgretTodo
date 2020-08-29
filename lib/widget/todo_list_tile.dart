import 'package:animations/animations.dart';
import 'package:egret_todo/model/todo_item_model.dart';
import 'package:egret_todo/page/todo_Item_detail_page.dart';
import 'package:egret_todo/util/NavigatorUtil.dart';
import 'package:egret_todo/widget/deleted_text.dart';
import 'package:flutter/material.dart';


class TodoListTile extends StatefulWidget {
  TodoItemModel todoItemModel;

  TodoListTile(this.todoItemModel);

  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  bool _finished;

  @override
  Widget build(BuildContext context) {
    TodoItemModel todoItem = widget.todoItemModel;
    _finished = todoItem.finished;
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (context, openContainer) {
        print(1);
        return TodoItemDetailPage(todoItem);
      },
      tappable: true,
      closedShape: const RoundedRectangleBorder(),
      closedElevation: 0,
      closedBuilder: (context, openContainer) {
        return ListTile(
          leading: Checkbox(
            value: _finished,
            onChanged: (val) {
              todoItem.finished = val;
              setState(() {
                _finished = todoItem.finished;
              });
            },
          ),
          title: _finished
              ? DeletedText(todoItem.title)
              : Text(
            todoItem.title,
          ),
          subtitle: todoItem.subTitle != null
              ? (_finished
              ? DeletedText(todoItem.subTitle)
              : Text(todoItem.subTitle))
              : null,
          // trailing: IconButton(icon: Icon(Icons.play_arrow),onPressed: (){}),

        );
      },
    );

  }
}
