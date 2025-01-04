import 'package:equatable/equatable.dart';
import '../../../../data/models/task.dart';

abstract class SearchTaskState extends Equatable {
  const SearchTaskState();

  @override
  List<Object?> get props => [];
}

class SearchTaskInitialState extends SearchTaskState {}

class SearchTaskLoadingState extends SearchTaskState {}

class SearchTaskLoadedState extends SearchTaskState {
  final List<Task> tasks;

  const SearchTaskLoadedState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class SearchTaskErrorState extends SearchTaskState {
  final String message;

  const SearchTaskErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
