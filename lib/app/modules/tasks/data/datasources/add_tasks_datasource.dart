import '../models/task.dart';

abstract class AddTaskDataSource {
  Future<int> addTask(Task task);
}
