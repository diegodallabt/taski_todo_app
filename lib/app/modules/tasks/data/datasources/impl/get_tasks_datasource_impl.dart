import '../../database/tasks_database.dart';
import '../../models/task.dart';
import '../get_tasks_datasource.dart';

class GetTasksDataSourceImpl implements GetTasksDataSource {
  final TasksDatabase db;

  GetTasksDataSourceImpl(this.db);

  @override
  Future<List<Task>> fetchTasksByDone(bool isCompleted,
      {int offset = 0, int limit = 10}) async {
    final result = await db.fetchTasksByDone(
      isCompleted,
      offset: offset,
      limit: limit,
    );

    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<int> countTasks(bool isCompleted) async {
    return await db.countTasks(isCompleted);
  }

  @override
  Future<List<Task>> searchTasks(String query,
      {int offset = 0, int limit = 10}) async {
    final result = await db.searchTasks(
      query,
      offset: offset,
      limit: limit,
    );

    return result.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<void> deleteAllTasks() async {
    await db.deleteAllTasks();
  }
}
