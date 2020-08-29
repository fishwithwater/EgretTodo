import 'package:egret_todo/model/todo_item_model.dart';
import 'package:flutter/material.dart';

class TodoItemDetailPage extends StatefulWidget {
  TodoItemModel todoItemModel;

  TodoItemDetailPage(this.todoItemModel);

  @override
  _TodoItemDetailPageState createState() => _TodoItemDetailPageState();
}

class _TodoItemDetailPageState extends State<TodoItemDetailPage> {
  TodoItemModel _todoItemModel;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    _todoItemModel = widget.todoItemModel == null
        ? TodoItemModel(null)
        : widget.todoItemModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('清单详情'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: '主题', contentPadding: EdgeInsets.all(10.0)),
                autofocus: true,
                initialValue: _todoItemModel.title,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '描述', contentPadding: EdgeInsets.all(10.0)),
                initialValue: _todoItemModel.subTitle,
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: Text('确定'),
                      color: themeData.colorScheme.primary,
                      textColor: themeData.colorScheme.surface,
                      onPressed: () {},
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
