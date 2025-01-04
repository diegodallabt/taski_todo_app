import '../models/task.dart';

abstract class SearchTasksDataSource {
  Future<List<Task>> searchTasks(String query);
}
