import '../../datasources/update_task_status_datasource.dart';
import '../update_task_status_repository.dart';

class UpdateTaskStatusRepositoryImpl implements UpdateTaskStatusRepository {
  final UpdateTaskStatusDataSource dataSource;

  UpdateTaskStatusRepositoryImpl(this.dataSource);

  @override
  Future<void> updateTaskStatus(int id) async {
    await dataSource.updateTaskStatus(id);
  }
}
