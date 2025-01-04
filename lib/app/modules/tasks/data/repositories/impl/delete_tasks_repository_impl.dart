import '../../datasources/delete_tasks_datasource.dart';
import '../delete_tasks_repository.dart';

class DeleteTasksRepositoryImpl implements DeleteTasksRepository {
  final DeleteTasksDataSource dataSource;

  DeleteTasksRepositoryImpl(this.dataSource);

  @override
  Future<void> deleteAllTasks() async {
    return await dataSource.deleteAllTasks();
  }

  @override
  Future<void> deleteTask(int id) async {
    return await dataSource.deleteTask(id);
  }
}
