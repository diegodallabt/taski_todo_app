import '../models/task.dart';

abstract class GetTasksRepository {
  Future<List<Task>> fetchTasks();
  Future<void> deleteAllTasks();
}
