import '../models/task.dart';

abstract class GetTasksDataSource {
  Future<List<Task>> fetchTasks();
  Future<List<Task>> searchTasks(String query);
  Future<void> deleteAllTasks();
}
