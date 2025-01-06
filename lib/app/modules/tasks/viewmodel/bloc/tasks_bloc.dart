import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/app/modules/tasks/data/repositories/delete_tasks_repository.dart';
import '../../data/models/task.dart';
import '../../data/repositories/add_tasks_repository.dart';
import '../../data/repositories/get_tasks_repository.dart';
import '../../data/repositories/update_task_status_repository.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksRepository getRepository;
  final AddTaskRepository addRepository;
  final UpdateTaskStatusRepository updateRepository;
  final DeleteTasksRepository deleteRepository;

  TaskBloc(this.getRepository, this.addRepository, this.updateRepository,
      this.deleteRepository)
      : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        await Future.delayed(const Duration(seconds: 1));

        final tasks = await getRepository.fetchTasksByDone(event.isCompleted);
        final totalTasks = await getRepository.countTasks(event.isCompleted);

        emit(TaskLoaded(tasks: tasks, totalTasks: totalTasks));
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

        final tasks = await getRepository.searchTasks('');
        final totalTasks = await getRepository.countTasks(event.isCompleted);

        emit(TaskLoaded(tasks: tasks, totalTasks: totalTasks));
      } catch (e) {
        emit(TaskError('Failed to add task. $e'));
      }
    });

    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());

      try {
        await updateRepository.updateTaskStatus(event.id);

        final tasks = await getRepository.searchTasks('');
        final totalTasks = await getRepository.countTasks(false);

        emit(TaskLoaded(tasks: tasks, totalTasks: totalTasks));
      } catch (e) {
        emit(TaskError('Failed to update task.'));
      }
    });

    on<SearchTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getRepository.searchTasks(event.query);
        final totalTasks = await getRepository.countTasks(false);

        emit(TaskLoaded(
          tasks: tasks,
          totalTasks: totalTasks,
          hasMore: tasks.length < totalTasks,
        ));
      } catch (e) {
        emit(TaskError('Failed to search tasks.'));
      }
    });

    on<DeleteAllTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        await deleteRepository.deleteAllTasks();

        final tasks = await getRepository.fetchTasksByDone(true);
        final totalTasks = await getRepository.countTasks(true);

        emit(TaskLoaded(tasks: tasks, totalTasks: totalTasks));
      } catch (e) {
        emit(TaskError('Failed to delete all tasks.'));
      }
    });

    on<DeleteTask>((event, emit) async {
      emit(TaskLoading());

      try {
        await deleteRepository.deleteTask(event.id);

        final tasks = await getRepository.fetchTasksByDone(true);
        final totalTasks = await getRepository.countTasks(true);

        emit(TaskLoaded(tasks: tasks, totalTasks: totalTasks));
      } catch (e) {
        emit(TaskError('Failed to delete task with id ${event.id}.'));
      }
    });

    on<LoadMoreTasks>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;

        if (currentState.isLoadingMore || !currentState.hasMore) {
          return;
        }

        final totalTasks = await getRepository.countTasks(event.isCompleted);

        emit(TaskLoaded(
          tasks: currentState.tasks,
          hasMore: currentState.hasMore,
          isLoadingMore: true,
          totalTasks: totalTasks,
        ));

        try {
          final newTasks = await getRepository.fetchTasksByDone(
            event.isCompleted,
            offset: currentState.tasks.length,
            limit: 10,
          );

          final totalTasks = await getRepository.countTasks(event.isCompleted);

          emit(TaskLoaded(
            tasks: currentState.tasks + newTasks,
            hasMore: newTasks.isNotEmpty,
            isLoadingMore: false,
            totalTasks: totalTasks,
          ));
        } catch (e) {
          emit(TaskError('Failed to load more tasks.'));
        }
      }
    });

    on<LoadMoreSearchTasks>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;

        if (currentState.isLoadingMore || !currentState.hasMore) {
          return;
        }

        emit(TaskLoaded(
          tasks: currentState.tasks,
          hasMore: currentState.hasMore,
          isLoadingMore: true,
          totalTasks: currentState.totalTasks,
        ));

        try {
          final newTasks = await getRepository.searchTasks(
            event.query,
            offset: currentState.tasks.length,
            limit: 10,
          );

          emit(TaskLoaded(
            tasks: currentState.tasks + newTasks,
            hasMore: newTasks.isNotEmpty,
            isLoadingMore: false,
            totalTasks: currentState.totalTasks,
          ));
        } catch (e) {
          emit(TaskError('Failed to load more search tasks.'));
        }
      }
    });
  }
}
