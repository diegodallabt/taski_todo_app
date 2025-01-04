import '../models/task.dart';

abstract class GetTasksRepository {
  Future<List<Task>> fetchTasksByDone(bool isCompleted);
  Future<List<Task>> searchTasks(String query);
  Future<void> deleteAllTasks();
}
