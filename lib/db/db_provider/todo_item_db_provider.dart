import 'package:egret_todo/db/db_provider/base_db_provider.dart';
import 'package:egret_todo/db/util.dart';
import 'package:egret_todo/error/app_error.dart';
import 'package:egret_todo/model/todo_item_model.dart';
import 'package:sqflite/sqflite.dart';

class TodoItemDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'TodoItem';

  @override
  final Map<String, Column> columnMap = {
    'id': Column('id', dartType: DartType.INTEGER, primaryKey: true),
    'title': Column('title'),
    'subTitle': Column('subTitle'),
    'finished': Column('finished', dartType: DartType.BOOLEAN),
    'deadline': Column('deadline', dartType: DartType.DATETIME),
    'priority': Column('priority', dartType: DartType.INTEGER)
  };

  TodoItemDbProvider();

  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    var columnCreateSql = getColumnCreateSql();
    var str = '''
        create table $name (
        $columnCreateSql
        )
      ''';
    return str;
  }

  Future<TodoItemModel> read(int id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> resultList =
        await db.rawQuery("select * from $name where id = $id");
    if (resultList.length > 0) {
      Map<String, dynamic> result = resultList[0];
      return TodoItemModel.fromJson(handleResult(result));
    }
    return null;
  }

  Future<List<TodoItemModel>> getAll() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> resultList =
        await db.rawQuery("select * from $name");
    if (resultList.length > 0) {
      return List.generate(resultList.length, (index) => TodoItemModel.fromJson(handleResult(resultList[index])));
    }
    return [];
  }

  ///插入到数据库
  Future insert(TodoItemModel model) async {
    Database db = await getDataBase();
    TodoItemModel userModel = await read(model.id);
    if (userModel != null) {
      throw AppError('主键冲突');
    }
    return await db.insert(name, _preSave(model));
  }

  Map _preSave(TodoItemModel model) {
    var map = model.toJson();
    map.forEach((key, value) {
      map.update(key,
          (value) => columnMap[key]?.typeHandler.beforeSet(value) ?? value);
    });
    return map;
  }

//
// ///更新数据库
// Future<void> update(UserModel model) async {
//   Database database = await getDataBase();
//   await database.rawUpdate(
//       "update $name set $columnMobile = ?,$columnHeadImage = ? where $columnId= ?",[model.mobile,model.headImage,model.id]);
//
// }
//
//
// ///获取事件数据
// Future<UserModel> getPersonInfo(int id) async {
//   Database db = await getDataBase();
//   List<Map<String, dynamic>> maps  = await _getPersonProvider(db, id);
//   if (maps.length > 0) {
//     return UserModel.fromJson(maps[0]);
//   }
//   return null;
// }
}
