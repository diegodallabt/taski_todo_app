import 'package:taski/app/modules/tasks/data/database/tasks_database.dart';

import '../../models/task.dart';
import '../search_tasks_datasource.dart';

class SearchTasksDataSourceImpl implements SearchTasksDataSource {
  final TasksDatabase _database;

  SearchTasksDataSourceImpl(this._database);

  @override
  Future<List<Task>> searchTasks(String query) async {
    final result = await _database.fetchTasks(query);
    return result.map((json) => Task.fromJson(json)).toList();
  }
}
