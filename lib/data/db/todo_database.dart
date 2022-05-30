import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/data/db/todo_dao.dart';
import 'package:todo_flutter/data/model/todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(TodoDao.CREATE_TABLE);
  }

  Future<Todo> insert(Todo todo) async {
    final db = await instance.database;
    final int id = await db.insert(TodoDao.TABLE_NAME, todo.toMap());
    return todo.copy(id: id);
  }

  Future<Todo> get(int id) async {
    final db = await instance.database;
    final todos = await db.query(TodoDao.TABLE_NAME,
        columns: TodoFields.values,
        where: '${TodoFields.id} = ?',
        whereArgs: [id]);

    if (todos.isNotEmpty) {
      return Todo.fromMap(todos.first);
    } else {
      throw new Exception('Id $id not found');
    }
  }

  Future<List<Todo>> findAll() async {
    final db = await instance.database;
    final todos = await db.query(TodoDao.TABLE_NAME);
    return todos.map((todo) => Todo.fromMap(todo)).toList();
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;
    return await db.update(TodoDao.TABLE_NAME, todo.toMap(), where: '${TodoFields.id} = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(TodoDao.TABLE_NAME, where: '${TodoFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
