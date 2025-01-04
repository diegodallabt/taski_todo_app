import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {
  final bool isCompleted;

  const LoadTasks({required this.isCompleted});

  @override
  List<Object?> get props => [isCompleted];
}

class UpdateTask extends TaskEvent {
  final int id;

  const UpdateTask({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class RefreshTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String? description;
  final bool isCompleted = false;

  const AddTask({required this.title, this.description});

  @override
  List<Object?> get props => [title, description, isCompleted];
}

class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}

class DeleteAllTasks extends TaskEvent {}

class DeleteTask extends TaskEvent {
  final int id;

  const DeleteTask(this.id);

  @override
  List<Object?> get props => [id];
}
