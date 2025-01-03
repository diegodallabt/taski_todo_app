import '../datasources/get_tasks_datasource.dart';
import '../models/task.dart';
import 'get_tasks_repository.dart';

class GetTasksRepositoryImpl implements GetTasksRepository {
  final GetTasksDataSource dataSource;

  GetTasksRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> fetchTasks() async {
    return await dataSource.fetchTasks();
  }
}
