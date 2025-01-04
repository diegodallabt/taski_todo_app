import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/search_tasks_repository.dart';

import 'search_task_event.dart';
import 'search_task_state.dart';

class SearchTaskBloc extends Bloc<SearchTaskEvent, SearchTaskState> {
  final SearchTasksRepository repository;

  SearchTaskBloc(this.repository) : super(SearchTaskInitialState()) {
    on<SearchTasks>((event, emit) async {
      emit(SearchTaskLoadingState());
      try {
        final tasks = await repository.searchTasks(event.query);
        emit(SearchTaskLoadedState(tasks: tasks));
      } catch (e) {
        emit(SearchTaskErrorState(message: 'Failed to fetch tasks: $e'));
      }
    });
  }
}
