import 'package:equatable/equatable.dart';

import '../../data/models/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final int totalTasks;
  final bool hasMore;
  final bool isLoadingMore;

  const TaskLoaded({
    required this.tasks,
    required this.totalTasks,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [tasks, hasMore, isLoadingMore];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
