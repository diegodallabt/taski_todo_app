import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      isCompleted INTEGER NOT NULL
    )
    ''');
  }

  Future<List<Map<String, dynamic>>> fetchTasksByDone(bool done,
      {int offset = 0, int limit = 10}) async {
    final db = await instance.database;

    final result = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [done ? 1 : 0],
      limit: limit,
      offset: offset,
    );

    return result;
  }

  Future<int> countTasks(bool done) async {
    final db = await instance.database;

    final result = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM tasks WHERE isCompleted = ?',
      [done ? 1 : 0],
    ));

    return result ?? 0;
  }

  Future<int> addTask(
      String title, String description, bool isCompleted) async {
    final db = await instance.database;

    final id = await db.insert(
      'tasks',
      {
        'title': title,
        'description': description,
        'isCompleted': 0,
      },
    );
    return id;
  }

  Future<void> updateTaskStatus(int id) async {
    final db = await instance.database;

    await db.update(
      'tasks',
      {'isCompleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllTasks() async {
    final db = await instance.database;

    await db.delete('tasks', where: 'isCompleted = ?', whereArgs: [1]);
  }

  Future<void> deleteTaskById(int id) async {
    final db = await instance.database;

    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> searchTasks(String query,
      {int offset = 0, int limit = 10}) async {
    final db = await instance.database;

    if (query.isEmpty) {
      return await db.query(
        'tasks',
        where: 'isCompleted = ?',
        whereArgs: [0],
        limit: limit,
        offset: offset,
      );
    }

    return await db.query(
      'tasks',
      where: 'title LIKE ? AND isCompleted = ?',
      whereArgs: ['%$query%', 0],
      limit: limit,
      offset: offset,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
