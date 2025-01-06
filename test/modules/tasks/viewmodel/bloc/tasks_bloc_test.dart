import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/app/modules/tasks/data/models/task.dart';
import 'package:taski/app/modules/tasks/viewmodel/bloc/tasks_bloc.dart';
import 'package:taski/app/modules/tasks/viewmodel/bloc/tasks_event.dart';
import 'package:taski/app/modules/tasks/viewmodel/bloc/tasks_state.dart';
import 'package:taski/app/modules/tasks/data/repositories/add_tasks_repository.dart';
import 'package:taski/app/modules/tasks/data/repositories/delete_tasks_repository.dart';
import 'package:taski/app/modules/tasks/data/repositories/get_tasks_repository.dart';
import 'package:taski/app/modules/tasks/data/repositories/update_task_status_repository.dart';

class MockGetTasksRepository extends Mock implements GetTasksRepository {}

class MockAddTasksRepository extends Mock implements AddTaskRepository {}

class MockUpdateTaskStatusRepository extends Mock
    implements UpdateTaskStatusRepository {}

class MockDeleteTasksRepository extends Mock implements DeleteTasksRepository {}

class FakeTask extends Fake implements Task {}

void main() {
  late MockGetTasksRepository getRepository;
  late MockAddTasksRepository addRepository;
  late MockUpdateTaskStatusRepository updateRepository;
  late MockDeleteTasksRepository deleteRepository;
  late TaskBloc taskBloc;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    getRepository = MockGetTasksRepository();
    addRepository = MockAddTasksRepository();
    updateRepository = MockUpdateTaskStatusRepository();
    deleteRepository = MockDeleteTasksRepository();

    taskBloc = TaskBloc(
      getRepository,
      addRepository,
      updateRepository,
      deleteRepository,
    );
  });

  group('BloC Tests', () {
    group('LoadTasks', () {
      blocTest<TaskBloc, TaskState>(
        'LoadTasks is successful test',
        build: () {
          when(() => getRepository.fetchTasksByDone(false))
              .thenAnswer((_) async => [
                    Task(
                      id: 1,
                      title: 'Sample Task',
                      description: 'Sample Description',
                      isCompleted: false,
                    ),
                  ]);
          when(() => getRepository.countTasks(false))
              .thenAnswer((_) async => 1);
          return taskBloc;
        },
        act: (bloc) => bloc.add(const LoadTasks(isCompleted: false)),
        wait: const Duration(seconds: 1),
        expect: () => [
          TaskLoading(),
          TaskLoaded(tasks: [
            Task(
              id: 1,
              title: 'Sample Task',
              description: 'Sample Description',
              isCompleted: false,
            ),
          ], totalTasks: 1),
        ],
      );

      blocTest<TaskBloc, TaskState>(
        'LoadTasks fails test',
        build: () {
          when(() => getRepository.fetchTasksByDone(true))
              .thenThrow(Exception('Failed to load tasks'));
          return taskBloc;
        },
        act: (bloc) => bloc.add(const LoadTasks(isCompleted: true)),
        wait: const Duration(seconds: 1),
        expect: () => [
          TaskLoading(),
          const TaskError('Failed to load tasks.'),
        ],
      );
    });

    group('AddTask', () {
      blocTest<TaskBloc, TaskState>(
        'AddTask is successful test',
        build: () {
          when(() => addRepository.addTask(any())).thenAnswer((_) async => 1);
          when(() => getRepository.searchTasks('')).thenAnswer((_) async => [
                Task(
                  id: 1,
                  title: 'New Task',
                  description: 'Description',
                  isCompleted: false,
                ),
              ]);
          when(() => getRepository.countTasks(false))
              .thenAnswer((_) async => 1);
          return taskBloc;
        },
        act: (bloc) => bloc.add(const AddTask(
          title: 'New Task',
          description: 'Description',
        )),
        expect: () => [
          TaskLoading(),
          TaskLoaded(
            tasks: [
              Task(
                id: 1,
                title: 'New Task',
                description: 'Description',
                isCompleted: false,
              ),
            ],
            totalTasks: 1,
          ),
        ],
      );

      blocTest<TaskBloc, TaskState>(
        'AddTask fails test',
        build: () {
          when(() => addRepository.addTask(any()))
              .thenThrow(Exception('Failed to add task'));
          return taskBloc;
        },
        act: (bloc) => bloc.add(const AddTask(
          title: 'New Task',
          description: 'Description',
        )),
        expect: () => [
          TaskLoading(),
          const TaskError('Failed to add task. Exception: Failed to add task'),
        ],
      );
    });

    group('SearchTasks', () {
      blocTest<TaskBloc, TaskState>(
        'SearchTasks is successful test',
        build: () {
          when(() => getRepository.searchTasks('query'))
              .thenAnswer((_) async => [
                    Task(
                      id: 1,
                      title: 'Search Task',
                      description: 'Description',
                      isCompleted: false,
                    ),
                  ]);
          when(() => getRepository.countTasks(false))
              .thenAnswer((_) async => 1);
          return taskBloc;
        },
        act: (bloc) => bloc.add(const SearchTasks('query')),
        expect: () => [
          TaskLoading(),
          TaskLoaded(
            tasks: [
              Task(
                id: 1,
                title: 'Search Task',
                description: 'Description',
                isCompleted: false,
              ),
            ],
            hasMore: false,
            isLoadingMore: false,
            totalTasks: 1,
          ),
        ],
      );

      blocTest<TaskBloc, TaskState>(
        'SearchTasks fails test',
        build: () {
          when(() => getRepository.searchTasks('query'))
              .thenThrow(Exception('Failed to search tasks'));
          return taskBloc;
        },
        act: (bloc) => bloc.add(const SearchTasks('query')),
        expect: () => [
          TaskLoading(),
          const TaskError('Failed to search tasks.'),
        ],
      );
    });

    group('DeleteTask', () {
      blocTest<TaskBloc, TaskState>(
        'DeleteTask is successful test',
        build: () {
          when(() => deleteRepository.deleteTask(1)).thenAnswer((_) async {});
          when(() => getRepository.fetchTasksByDone(true))
              .thenAnswer((_) async => []);
          when(() => getRepository.countTasks(true)).thenAnswer((_) async => 1);
          return taskBloc;
        },
        act: (bloc) => bloc.add(const DeleteTask(1)),
        expect: () => [
          TaskLoading(),
          TaskLoaded(
            tasks: [],
            totalTasks: 0,
          ),
        ],
      );

      blocTest<TaskBloc, TaskState>(
        'DeleteTask fails test',
        build: () {
          when(() => deleteRepository.deleteTask(1))
              .thenThrow(Exception('Failed to delete task'));
          return taskBloc;
        },
        act: (bloc) => bloc.add(const DeleteTask(1)),
        expect: () => [
          TaskLoading(),
          const TaskError('Failed to delete task with id 1.'),
        ],
      );
    });
  });
}
