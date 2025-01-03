import 'package:flutter_modular/flutter_modular.dart';
import 'package:taski/app/modules/tasks/presentation/tasks/tasks_page.dart';

class TasksModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const TasksPage(),
    );
  }
}
