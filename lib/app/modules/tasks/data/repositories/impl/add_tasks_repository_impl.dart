import '../../datasources/add_tasks_datasource.dart';
import '../../models/task.dart';
import '../add_tasks_repository.dart';

class AddTaskRepositoryImpl implements AddTaskRepository {
  final AddTaskDataSource addTaskDataSource;

  AddTaskRepositoryImpl(this.addTaskDataSource);

  @override
  Future<int> addTask(Task task) async {
    return await addTaskDataSource.addTask(task);
  }
}
