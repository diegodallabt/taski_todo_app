import '../../datasources/get_tasks_datasource.dart';
import '../../models/task.dart';
import '../get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDataSource dataSource;

  GetTasksRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> fetchTasksByDone(bool isCompleted) async {
    return await dataSource.fetchTasksByDone(isCompleted);
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    try {
      return await dataSource.searchTasks(query);
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    return await dataSource.deleteAllTasks();
  }
}
