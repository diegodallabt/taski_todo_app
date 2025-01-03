import '../database/tasks_database.dart';
import '../models/task.dart';
import 'get_tasks_datasource.dart';

class GetTasksDataSourceImpl implements GetTasksDataSource {
  final db = TasksDatabase.instance;

  @override
  Future<List<Task>> fetchTasks() async {
    final database = await db.database;

    final result = await database.query('tasks');
    return result.map((json) => Task.fromJson(json)).toList();
  }
}
