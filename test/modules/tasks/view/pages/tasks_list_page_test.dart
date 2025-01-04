import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/app/modules/tasks/data/models/task.dart';
import 'package:taski/app/modules/tasks/view/tasks/list/tasks_list_page.dart';
import 'package:taski/app/modules/tasks/viewmodel/bloc/tasks_bloc.dart';
import 'package:taski/app/modules/tasks/viewmodel/bloc/tasks_state.dart';
import 'package:taski/app/widgets/skeleton.dart';

class MockTaskBloc extends Mock implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  group('Widget Tests', () {
    setUpAll(() {
      mockTaskBloc = MockTaskBloc();
      Modular.init(TestAppModule(mockTaskBloc));
      Modular.bindModule(TestAppModule(mockTaskBloc));
    });

    tearDownAll(() {
      Modular.destroy();
    });

    testWidgets('Displays skeleton on loading test',
        (WidgetTester tester) async {
      when(() => mockTaskBloc.state).thenReturn(TaskLoading());
      when(() => mockTaskBloc.stream)
          .thenAnswer((_) => Stream.value(TaskLoading()));

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        ),
      );

      await tester.pump();

      expect(find.byType(Skeleton), findsOneWidget);
    });

    testWidgets('Displays tasks test', (WidgetTester tester) async {
      when(() => mockTaskBloc.state).thenReturn(TaskLoaded(tasks: [
        Task(
            id: 1,
            title: 'Task 1',
            description: 'Description 1',
            isCompleted: false),
        Task(
            id: 2,
            title: 'Task 2',
            description: 'Description 2',
            isCompleted: true),
      ]));
      when(() => mockTaskBloc.stream)
          .thenAnswer((_) => Stream.value(TaskLoaded(tasks: [
                Task(
                    id: 1,
                    title: 'Task 1',
                    description: 'Description 1',
                    isCompleted: false),
                Task(
                    id: 2,
                    title: 'Task 2',
                    description: 'Description 2',
                    isCompleted: true),
              ])));

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        ),
      );

      expect(find.text("You've got 2 tasks to do."), findsOneWidget);
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('Displays error message test', (WidgetTester tester) async {
      when(() => mockTaskBloc.state)
          .thenReturn(TaskError('Failed to load tasks.'));
      when(() => mockTaskBloc.stream)
          .thenAnswer((_) => Stream.value(TaskError('Failed to load tasks.')));

      await tester.pumpWidget(
        MaterialApp.router(
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        ),
      );

      expect(find.text('Failed to load tasks.'), findsOneWidget);
    });
  });
}

class TestAppModule extends Module {
  final MockTaskBloc mockTaskBloc;

  TestAppModule(this.mockTaskBloc);

  @override
  void binds(Injector i) {
    i.addSingleton<TaskBloc>(() => mockTaskBloc);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => TasksListPage(),
    );
  }
}
