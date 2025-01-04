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

        final tasks = await getRepository.searchTasks('');

        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to add task. $e'));
      }
    });

    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());

      try {
        await updateRepository.updateTaskStatus(event.id);

        final tasks = await getRepository.searchTasks('');
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to update task.'));
      }
    });

    on<SearchTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getRepository.searchTasks(event.query);
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to search tasks.'));
      }
    });

    on<DeleteAllTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        await deleteRepository.deleteAllTasks();

        final tasks = await getRepository.fetchTasksByDone(true);
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to delete all tasks.'));
      }
    });

    on<DeleteTask>((event, emit) async {
      emit(TaskLoading());

      try {
        await deleteRepository.deleteTask(event.id);

        final tasks = await getRepository.fetchTasksByDone(true);
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError('Failed to delete task with id ${event.id}.'));
      }
    });
  }
}
