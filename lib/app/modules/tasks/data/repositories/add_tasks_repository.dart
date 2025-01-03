import '../models/task.dart';

abstract class AddTaskRepository {
  Future<int> addTask(Task task);
}
