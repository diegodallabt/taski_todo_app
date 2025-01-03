import '../../database/tasks_database.dart';
import '../../models/task.dart';
import '../add_tasks_datasource.dart';

class AddTaskDataSourceImpl implements AddTaskDataSource {
  final TasksDatabase db;

  AddTaskDataSourceImpl(this.db);

  @override
  Future<int> addTask(Task task) async {
    return await db.addTask(
      task.title,
      task.description ?? '',
      task.isCompleted,
    );
  }
}
