import 'package:todo_flutter/data/model/todo.dart';

class TodoDao {
  static const TABLE_NAME = 'todos';
  static const CREATE_TABLE = '''
  CREATE TABLE $TABLE_NAME (
  ${TodoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${TodoFields.todo} TEXT NOT NULL,
  ${TodoFields.description} TEXT NOT NULL,
  ${TodoFields.isComplete} BOOLEAN NOT NULL
  )
  ''';
}