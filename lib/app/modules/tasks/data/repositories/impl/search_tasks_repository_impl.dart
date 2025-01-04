import 'package:taski/app/modules/tasks/data/datasources/search_tasks_datasource.dart';

import '../../models/task.dart';
import '../search_tasks_repository.dart';

class SearchTasksRepositoryImpl implements SearchTasksRepository {
  final SearchTasksDataSource dataSource;

  SearchTasksRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> searchTasks(String query) async {
    try {
      return await dataSource.searchTasks(query);
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }
}
