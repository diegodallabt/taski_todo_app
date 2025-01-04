import '../models/task.dart';

abstract class GetTasksDataSource {
  Future<List<Task>> fetchTasksByDone(bool isCompleted);
  Future<List<Task>> searchTasks(String query);
  Future<void> deleteAllTasks();
}
