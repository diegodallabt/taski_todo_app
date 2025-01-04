import '../../database/tasks_database.dart';
import '../../models/task.dart';
import '../get_tasks_datasource.dart';

class GetTasksDataSourceImpl implements GetTasksDataSource {
  final TasksDatabase db;

  GetTasksDataSourceImpl(this.db);

  @override
  Future<List<Task>> fetchTasks() async {
    final result = await db.fetchAllTasks();
    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    final result = await db.searchTasks(query);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<void> deleteAllTasks() async {
    await db.deleteAllTasks();
  }
}
