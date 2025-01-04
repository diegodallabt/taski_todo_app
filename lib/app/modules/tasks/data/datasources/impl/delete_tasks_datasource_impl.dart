import '../../database/tasks_database.dart';
import '../delete_tasks_datasource.dart';

class DeleteTasksDataSourceImpl implements DeleteTasksDataSource {
  final TasksDatabase db;

  DeleteTasksDataSourceImpl(this.db);

  @override
  Future<void> deleteAllTasks() async {
    await db.deleteAllTasks();
  }

  @override
  Future<void> deleteTask(int id) async {
    await db.deleteTaskById(id);
  }
}
