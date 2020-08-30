enum DartType { INTEGER, DOUBLE, STRING, DATETIME, BOOLEAN }

enum DbType { INTEGER, REAL, TEXT, BLOB }

class Column {
  DartType dartType;
  String columnName;
  DbType _dbType;
  bool primaryKey;
  TypeHandler typeHandler;

  Column(this.columnName,
      {this.dartType = DartType.STRING,
      this.primaryKey = false,
      this.typeHandler}) {
    switch (dartType) {
      case DartType.STRING:
        _dbType = DbType.TEXT;
        break;
      case DartType.DOUBLE:
        _dbType = DbType.REAL;
        break;
      case DartType.INTEGER:
        _dbType = DbType.INTEGER;
        break;
      case DartType.DATETIME:
        _dbType = DbType.TEXT;
        typeHandler = DateTimeTypeHandler();
        break;
      case DartType.BOOLEAN:
        _dbType = DbType.INTEGER;
        typeHandler = BooleanTypeHandler();
        break;
      default:
        _dbType = DbType.TEXT;
        break;
    }
    if (typeHandler == null) {
      typeHandler = DefaultTypeHandler();
    }
  }

  String getColumnName() {
    return columnName;
  }

  String getDbType() {
    switch (_dbType) {
      case DbType.TEXT:
        return 'text';
      case DbType.REAL:
        return 'real';
      case DbType.INTEGER:
        return 'integer';
      case DbType.BLOB:
        return 'blob';
      default:
        return 'text';
    }
  }

  String getCreateSqlSection() {
    String dbType = getDbType();
    return '$columnName $dbType ' + (primaryKey ? 'primary key' : '');
  }
}

abstract class TypeHandler {
  Object afterGet(Object data);

  Object beforeSet(Object data);
}

class DefaultTypeHandler implements TypeHandler {
  @override
  Object afterGet(Object data) {
    return data;
  }

  @override
  Object beforeSet(Object data) {
    return data;
  }
}

class BooleanTypeHandler implements TypeHandler {
  @override
  Object afterGet(Object data) {
    int currentData = data;
    if (currentData == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Object beforeSet(Object data) {
    bool currentData = data;
    if (currentData) {
      return 1;
    } else {
      return 0;
    }
  }
}

class DateTimeTypeHandler implements TypeHandler {
  @override
  Object afterGet(data) {
    DateTime time = null;
    if (data != null && data != "null") {
      time = DateTime.fromMillisecondsSinceEpoch(int.tryParse(data));
    }
    return time;
  }

  @override
  Object beforeSet(data) {
    DateTime dateTime = data;
    return dateTime?.millisecondsSinceEpoch.toString();
  }
}
