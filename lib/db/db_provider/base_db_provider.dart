import 'package:egret_todo/db/sql_manager.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../util.dart';

abstract class BaseDbProvider {
  bool isTableExits = false;

  final Map<String, Column> columnMap = {};

  String _columnCreateSql;

  String getColumnCreateSql() {
    if (_columnCreateSql == null) {
      _columnCreateSql =
          columnMap.values.map((e) => e.getCreateSqlSection()).join(",");
    }
    return _columnCreateSql;
  }

  String _columnSelectSql;

  String getColumnSelectSql() {
    if (_columnSelectSql == null) {
      _columnSelectSql = columnMap.keys.join(",");
    }
    return _columnSelectSql;
  }

  createTableString();

  tableName();

  ///创建表sql语句
  tableBaseString(String sql) {
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  List<Map<String, dynamic>> handleResultList(List<Map<String, dynamic>> resultList) {
    var newResultList = [];
    resultList.forEach((map) {
      newResultList.add(handleResult(map));
    });
    return newResultList;
  }

  Map<String, dynamic> handleResult(Map<String, dynamic> result) {
    Map<String, dynamic> newResult = {};
    result.forEach((key, value) {
      newResult[key] = columnMap[key]?.typeHandler.afterGet(value);
    });
    return newResult;
  }

  ///super 函数对父类进行初始化
  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
