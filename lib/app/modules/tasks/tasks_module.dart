import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/modules/tasks/data/datasources/add_tasks_datasource.dart';
import 'package:taski/app/modules/tasks/data/datasources/impl/add_tasks_datasource_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/add_tasks_repository.dart';
import 'package:taski/app/modules/tasks/data/repositories/impl/add_tasks_repository_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/impl/get_tasks_repository_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/impl/update_task_status_repository_impl.dart';
import 'package:taski/app/modules/tasks/data/repositories/update_task_status_repository.dart';
import 'package:taski/app/modules/tasks/view/tasks/done/tasks_done_page.dart';
import 'package:taski/app/modules/tasks/view/tasks/list/tasks_list_page.dart';

import 'data/database/tasks_database.dart';
import 'data/datasources/delete_tasks_datasource.dart';
import 'data/datasources/get_tasks_datasource.dart';
import 'data/datasources/impl/delete_tasks_datasource_impl.dart';
import 'data/datasources/impl/get_tasks_datasource_impl.dart';
import 'data/datasources/impl/update_task_status_datasource_impl.dart';
import 'data/datasources/update_task_status_datasource.dart';
import 'data/repositories/delete_tasks_repository.dart';
import 'data/repositories/get_tasks_repository.dart';
import 'data/repositories/impl/delete_tasks_repository_impl.dart';
import 'view/tasks/search/tasks_search_page.dart';
import 'viewmodel/bloc/tasks_bloc.dart';

class TasksModule extends Module {
  @override
  void binds(Injector i) {
    // Database
    i.addSingleton<TasksDatabase>(() => TasksDatabase.instance);

    // Datasources
    i.addSingleton<GetTasksDataSource>(
        () => GetTasksDataSourceImpl(i.get<TasksDatabase>()));
    i.addSingleton<AddTaskDataSource>(
        () => AddTaskDataSourceImpl(i.get<TasksDatabase>()));
    i.addSingleton<DeleteTasksDataSource>(
        () => DeleteTasksDataSourceImpl(i.get<TasksDatabase>()));
    i.addSingleton<UpdateTaskStatusDataSource>(
        () => UpdateTaskStatusDataSourceImpl(i.get<TasksDatabase>()));

    // Repositories
    i.addSingleton<GetTasksRepository>(
        () => GetTasksRepositoryImpl(i.get<GetTasksDataSource>()));
    i.addSingleton<AddTaskRepository>(
        () => AddTaskRepositoryImpl(i.get<AddTaskDataSource>()));
    i.addSingleton<DeleteTasksRepository>(
        () => DeleteTasksRepositoryImpl(i.get<DeleteTasksDataSource>()));
    i.addSingleton<UpdateTaskStatusRepository>(() =>
        UpdateTaskStatusRepositoryImpl(i.get<UpdateTaskStatusDataSource>()));

    // Bloc
    i.addSingleton<TaskBloc>(() => TaskBloc(
          i.get<GetTasksRepository>(),
          i.get<AddTaskRepository>(),
          i.get<UpdateTaskStatusRepository>(),
          i.get<DeleteTasksRepository>(),
        ));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TasksListPage(),
    );

    r.child(
      '/search',
      child: (context) => TasksSearchPage(),
    );

    r.child(
      '/done',
      child: (context) => TasksDonePage(),
    );
  }
}
