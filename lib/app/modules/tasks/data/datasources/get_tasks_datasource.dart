import '../models/task.dart';

abstract class GetTasksDataSource {
  Future<List<Task>> fetchTasks();
}
