abstract class DeleteTasksRepository {
  Future<void> deleteAllTasks();
  Future<void> deleteTask(int id);
}
