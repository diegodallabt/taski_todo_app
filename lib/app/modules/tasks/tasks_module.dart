import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/modules/tasks/data/datasources/add_tasks_datasource.dart';
import 'package:taski/app/modules/tasks/data/datasources/impl/add_tasks_datasource_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/add_tasks_repository.dart';
import 'package:taski/app/modules/tasks/data/repositories/impl/add_tasks_repository_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/impl/get_tasks_repository_impl.dart';
import 'package:taski/app/modules/tasks/view/tasks/list/tasks_list_page.dart';

import 'data/database/tasks_database.dart';
import 'data/datasources/get_tasks_datasource.dart';
import 'data/datasources/impl/get_tasks_datasource_impl.dart';
import 'data/repositories/get_tasks_repository.dart';
import 'viewmodel/tasks/list/bloc/tasks_bloc.dart';

class TasksModule extends Module {
  @override
  void binds(Injector i) {
    // Database
    i.addSingleton<TasksDatabase>(() => TasksDatabase.instance);

    // datasources
    i.addSingleton<GetTasksDataSource>(
        () => GetTasksDataSourceImpl(i.get<TasksDatabase>()));
    i.addSingleton<AddTaskDataSource>(
        () => AddTaskDataSourceImpl(i.get<TasksDatabase>()));

    // repositories
    i.addSingleton<GetTasksRepository>(
        () => GetTasksRepositoryImpl(i.get<GetTasksDataSource>()));
    i.addSingleton<AddTaskRepository>(
        () => AddTaskRepositoryImpl(i.get<AddTaskDataSource>()));

    // bloc
    i.addSingleton<TaskBloc>(() =>
        TaskBloc(i.get<GetTasksRepository>(), i.get<AddTaskRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TasksListPage(),
    );
  }
}
