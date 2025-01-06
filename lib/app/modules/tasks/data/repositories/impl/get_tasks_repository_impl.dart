import '../../datasources/get_tasks_datasource.dart';
import '../../models/task.dart';
import '../get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDataSource dataSource;

  GetTasksRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> fetchTasksByDone(bool isCompleted,
      {int offset = 0, int limit = 10}) async {
    final tasks = await dataSource.fetchTasksByDone(
      isCompleted,
      offset: offset,
      limit: limit,
    );

    return tasks;
  }

  @override
  Future<int> countTasks(bool isCompleted) async {
    return await dataSource.countTasks(isCompleted);
  }

  @override
  Future<List<Task>> searchTasks(String query,
      {int offset = 0, int limit = 10}) async {
    final result = await dataSource.searchTasks(
      query,
      offset: offset,
      limit: limit,
    );
    return result;
  }

  @override
  Future<void> deleteAllTasks() async {
    return await dataSource.deleteAllTasks();
  }
}
