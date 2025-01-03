import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class RefreshTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String? description;
  final bool isCompleted = false;

  const AddTask({required this.title, this.description});

  @override
  List<Object?> get props => [title, description, isCompleted];
}
