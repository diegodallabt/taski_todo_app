import '../models/task.dart';

abstract class GetTasksDataSource {
  Future<List<Task>> fetchTasksByDone(bool isCompleted,
      {int offset = 0, int limit = 10});
  Future<int> countTasks(bool isCompleted);
  Future<List<Task>> searchTasks(String query,
      {int offset = 0, int limit = 10});
  Future<void> deleteAllTasks();
}
