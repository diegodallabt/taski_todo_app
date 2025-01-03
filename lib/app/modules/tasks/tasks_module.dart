import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/modules/tasks/data/repositories/get_tasks_repository_impl.dart';
import 'package:taski/app/modules/tasks/view/tasks/list/tasks_list_page.dart';

import 'data/datasources/get_tasks_datasource.dart';
import 'data/datasources/get_tasks_datasource_impl.dart';
import 'data/repositories/get_tasks_repository.dart';
import 'viewmodel/tasks/list/bloc/tasks_bloc.dart';

class TasksModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<GetTasksDataSource>(() => GetTasksDataSourceImpl());
    i.addSingleton<GetTasksRepository>(
        () => GetTasksRepositoryImpl(i.get<GetTasksDataSource>()));
    i.addSingleton<TaskBloc>(() => TaskBloc(i.get<GetTasksRepository>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TasksListPage(),
    );
  }
}
