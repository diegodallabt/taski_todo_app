import 'package:equatable/equatable.dart';

abstract class SearchTaskEvent extends Equatable {
  const SearchTaskEvent();

  @override
  List<Object?> get props => [];
}

class SearchTasks extends SearchTaskEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}
