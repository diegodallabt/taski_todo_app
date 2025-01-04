abstract class DeleteTasksDataSource {
  Future<void> deleteAllTasks();
  Future<void> deleteTask(int id);
}
