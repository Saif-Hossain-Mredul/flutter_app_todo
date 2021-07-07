import 'dart:async';
import 'dart:io';
import 'package:flutter_app_todo/utilities/task-model.utilities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  Database _db;

  DatabaseHelper._instance();

  String _taskTable = 'task_table';
  String _colId = 'id';
  String _colTitle = 'title';
  String _colDate = 'date';
  String _colPriority = 'priority';
  String _colStatus = 'status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
    }

    return _db;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';

    final todoListDB =
        await openDatabase(path, version: 1, onCreate: _createDB);

    return todoListDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $_taskTable(
                $_colId INTEGER PRIMARY KEY AUTOINCREMENT, 
                $_colTitle TEXT, 
                $_colDate TEXT, 
                $_colPriority TEXT, 
                $_colStatus INTEGER
        )''');
  }

  Future<List<Task>> getTaskList() async {
    final List<Task> tasksList = [];

    Database db = await this.db;

    final List taskMapList = await db.query(_taskTable);
    taskMapList.forEach((taskMap) {
      tasksList.add(Task.fromMap(taskMap));
    });

    return tasksList;
  }

  Future insertTask(Task task) async {
    Database db = await this.db;

    final result = await db.insert(_taskTable, task.toMap());

    return result;
  }

  Future updateTask(Task task) async {
    Database db = await this.db;

    final result = await db.update(
      _taskTable,
      task.toMap(),
      where: '$_colId = ?',
      whereArgs: [task.id],
    );

    return result;
  }

  Future deleteTask(int id) async {
    Database db = await this.db;
    final result =
        await db.delete(_taskTable, where: '$_colId = ?', whereArgs: [id]);

    return result;
  }
}
