import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/task.dart';
import '../../../../data/repositories/add_tasks_repository.dart';
import '../../../../data/repositories/get_tasks_repository.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksRepository getRepository;
  final AddTaskRepository addRepository;

  TaskBloc(this.getRepository, this.addRepository) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        // await getRepository.deleteAllTasks();
        await Future.delayed(const Duration(seconds: 2));

        // final tasks = [
        //   Task(
        //     title: 'Design sign up flow',
        //     description:
        //         'By the time a prospect arrives at your signup page...',
        //   ),
        //   Task(
        //       title: 'Design use case page',
        //       description:
        //           'By the time a prospect arrives at your signup page...'),
        //   Task(
        //       title: 'Test Wireframe',
        //       description:
        //           'By the time a prospect arrives at your signup page...'),
        //   Task(
        //       title: 'Create new task UI flow',
        //       description:
        //           'By the time a prospect arrives at your signup page...'),
        //   Task(
        //       title: 'Collect project assets',
        //       description:
        //           'By the time a prospect arrives at your signup page...'),
        //   Task(
        //       title: 'Collect Skills list',
        //       description:
        //           'By the time a prospect arrives at your signup page...'),
        // ];

        final tasks = await getRepository.fetchTasks();

        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to load tasks.'));
      }
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());

      try {
        await addRepository.addTask(Task(
          title: event.title,
          description: event.description,
          isCompleted: event.isCompleted,
        ));

        final tasks = await getRepository.fetchTasks();
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to add task.'));
      }
    });
  }
}
