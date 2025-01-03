import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/modules/tasks/view/tasks/list/tasks_list_page.dart';

import 'viewmodel/tasks/list/bloc/tasks_bloc.dart';

class TasksModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<TaskBloc>(() => TaskBloc());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TasksListPage(),
    );
  }
}
