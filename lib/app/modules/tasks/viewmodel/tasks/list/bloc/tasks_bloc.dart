import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/task.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        await Future.delayed(const Duration(seconds: 2));

        final tasks = [
          const Task(
            title: 'Design sign up flow',
            description:
                'By the time a prospect arrives at your signup page...',
          ),
          const Task(
              title: 'Design use case page',
              description:
                  'By the time a prospect arrives at your signup page...'),
          const Task(
              title: 'Test Wireframe',
              description:
                  'By the time a prospect arrives at your signup page...'),
          const Task(
              title: 'Create new task UI flow',
              description:
                  'By the time a prospect arrives at your signup page...'),
          const Task(
              title: 'Collect project assets',
              description:
                  'By the time a prospect arrives at your signup page...'),
          const Task(
              title: 'Collect Skills list',
              description:
                  'By the time a prospect arrives at your signup page...'),
        ];

        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to load tasks.'));
      }
    });

    on<RefreshTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        await Future.delayed(const Duration(seconds: 2));

        final tasks = [
          const Task(
            title: 'Design sign up flow',
            description:
                'By the time a prospect arrives at your signup page...',
          ),
          const Task(title: 'Design use case page', description: ''),
          const Task(title: 'Test Wireframe', description: ''),
          const Task(title: 'Create new task UI flow', description: ''),
          const Task(title: 'Collect project assets', description: ''),
          const Task(title: 'Collect Skills list', description: ''),
        ];

        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to load tasks.'));
      }
    });
  }
}
