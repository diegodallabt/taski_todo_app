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

    await db.delete('tasks');
  }

  Future<List<Map<String, dynamic>>> fetchAllTasks() async {
    final db = await instance.database;

    return await db.query('tasks', where: 'isCompleted = 0');
  }

  Future<List<Map<String, dynamic>>> searchTasks(String query) async {
    final db = await instance.database;

    if (query.isEmpty) {
      return await db.query('tasks', where: 'isCompleted = 0');
    }

    return await db.query(
      'tasks',
      where: 'title LIKE ? AND isCompleted = 0',
      whereArgs: ['%$query%'],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
