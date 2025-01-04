import '../models/task.dart';

abstract class GetTasksRepository {
  Future<List<Task>> fetchTasks();
  Future<List<Task>> searchTasks(String query);
  Future<void> deleteAllTasks();
}
