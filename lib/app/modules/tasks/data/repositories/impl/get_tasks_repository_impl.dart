import '../../datasources/get_tasks_datasource.dart';
import '../../models/task.dart';
import '../get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDataSource dataSource;

  GetTasksRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> fetchTasks() async {
    return await dataSource.fetchTasks();
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    try {
      return await dataSource.searchTasks(query);
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  // temporary for testing
  @override
  Future<void> deleteAllTasks() async {
    return await dataSource.deleteAllTasks();
  }
}
