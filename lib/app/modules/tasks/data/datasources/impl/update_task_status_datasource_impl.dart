import '../../database/tasks_database.dart';
import '../update_task_status_datasource.dart';

class UpdateTaskStatusDataSourceImpl implements UpdateTaskStatusDataSource {
  final TasksDatabase db;

  UpdateTaskStatusDataSourceImpl(this.db);

  @override
  Future<void> updateTaskStatus(int id) async {
    await db.updateTaskStatus(id);
  }
}
