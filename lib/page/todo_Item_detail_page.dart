import 'package:egret_todo/db/db_provider/todo_item_db_provider.dart';
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
              Row(
                children: [
                  Checkbox(
                    value: _todoItemModel.finished,
                    onChanged: (val){
                      setState(() {
                        _todoItemModel.finished = val;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                style: TextStyle(fontSize: 25.0),
                decoration: InputDecoration(
                    hintText: '准备做什么？', contentPadding: EdgeInsets.all(10.0),border: InputBorder.none),
                autofocus: true,
                initialValue: _todoItemModel.title,
              ),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                    hintText: '简单描述一下', contentPadding: EdgeInsets.all(10.0),border: InputBorder.none),
                initialValue: _todoItemModel.subTitle,
              ),
              SizedBox(height: 10),
              RaisedButton(child: Text('确认'),onPressed: ()async{
                var dbProvider = TodoItemDbProvider();
                var result = await dbProvider.insert(_todoItemModel);
                print(result);
                var item = await dbProvider.read(result);
                print(item);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
