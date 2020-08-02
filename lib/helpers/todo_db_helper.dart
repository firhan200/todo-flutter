import 'package:blog/helpers/date_time_helper.dart';
import 'package:blog/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnSubTitle = 'subtitle';
final String columnDateTime = 'datetime';
final String columnIsCompleted = 'is_completed';

class TodoProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnSubTitle text not null,
  $columnDateTime text not null,
  $columnIsCompleted integer not null)
''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    final db = await database;
    todo.id = await db.insert(tableTodo, todo.toMap());
    print(todo.id);

    return todo;
  }

  Future<Todo> getTodo(int id) async {
    final db = await database;
    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnIsCompleted,
          columnTitle,
          columnSubTitle,
          columnDateTime
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = List<Todo>();

    final db = await database;
    var todosRaw = await db.query(tableTodo);

    todosRaw.forEach((element) {
      Todo todo = Todo.fromMap(element);

      todos.add(todo);
    });

    return todos;
  }

  Future<List<Todo>> getTodoByDate(DateTime dateTime) async {
    List<Todo> todos = List<Todo>();

    String selectedDate = DateTimeHelper.getFormattedDate(dateTime);

    final db = await database;
    var query = await db.rawQuery(
        'SELECT * FROM $tableTodo WHERE $columnDateTime = "$selectedDate"');

    query.forEach((e) {
      todos.add(Todo.fromMap(e));
    });

    return todos;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    final db = await database;
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }
}
