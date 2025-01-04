import '../models/task.dart';

abstract class SearchTasksRepository {
  Future<List<Task>> searchTasks(String query);
}
